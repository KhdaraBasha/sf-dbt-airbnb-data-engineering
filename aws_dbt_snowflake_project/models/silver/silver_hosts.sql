{{ config(materialized='incremental', unique_key = 'HOST_ID') }}

select 
    HOST_ID,
    {{ standardize_string('HOST_NAME') }} as HOST_NAME,
    CASE WHEN IS_SUPERHOST = 'false' then 0
        else 1 end as IS_SUPERHOST,
    HOST_SINCE,
    -- 1. Calculate the raw month difference
    datediff('MONTH', HOST_SINCE, current_date) as HOST_MONTHS_ACTIVE,    
    -- 2. Categorise the months into readable age buckets
    case 
        when HOST_SINCE is null then 'UNKNOWN'
        when datediff('MONTH', HOST_SINCE, current_date) < 6 then 'NEW (UNDER 6 MO)'
        when datediff('MONTH', HOST_SINCE, current_date) < 12 then '6-12 MONTHS'
        when datediff('MONTH', HOST_SINCE, current_date) < 36 then '1-3 YEARS'
        else 'VETERAN (3+ YEARS)'
    end as HOST_AGE_BUCKET,
    RESPONSE_RATE,
    case 
        when RESPONSE_RATE is null then 'NO RATE'
        when RESPONSE_RATE >= 95 and RESPONSE_RATE <= 100 then 'EXCELLENT (95-100%)'
        when RESPONSE_RATE >= 85 and RESPONSE_RATE < 95 then 'GOOD (85-94%)'
        when RESPONSE_RATE >= 70 and RESPONSE_RATE < 85 then 'AVERAGE (70-84%)'
        when RESPONSE_RATE < 70 then 'NEEDS IMPROVEMENT (<70%)'
        else 'INVALID SCORE' -- Handles edge cases like scores > 100
    end as RESPONSE_RATE_CLASS,
    CREATED_AT
from {{ ref('bronze_hosts') }}

{% if is_incremental() %}
    where CREATED_AT > (select coalesce(max(CREATED_AT), '1970-01-01'::date) from {{ this }})
{% endif %}