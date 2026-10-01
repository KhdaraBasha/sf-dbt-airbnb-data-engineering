{{ config(
    materialized='incremental',
    unique_key = 'LISTING_ID'
) }}

select 
        LISTING_ID,
        HOST_ID,
        -- FIXED: Removed single quotes from column names
        {{ standardize_string('PROPERTY_TYPE') }} as PROPERTY_TYPE,
        {{ standardize_string('ROOM_TYPE') }} as ROOM_TYPE,
        {{ standardize_string('CITY') }} as CITY,
        {{ standardize_string('COUNTRY') }} as COUNTRY,
        ACCOMMODATES,
        BEDROOMS,
        BATHROOMS,
        PRICE_PER_NIGHT,
        {{ price_tag('CAST(PRICE_PER_NIGHT as numeric)') }} as PRICE_TAG,
        CREATED_AT
from {{ ref('bronze_listings') }}

{% if is_incremental() %}
    where CREATED_AT > (select coalesce(max(CREATED_AT), '1970-01-01'::date) from {{ this }})
{% endif %}