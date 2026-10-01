{{ config(materialized='incremental') }}

select * from {{ source('STAGING', 'LISTINGS') }}

{% if is_incremental() %}
where CREATED_AT > (select coalesce(max(CREATED_AT), '1970-01-01') from {{ this }})
{% endif %}