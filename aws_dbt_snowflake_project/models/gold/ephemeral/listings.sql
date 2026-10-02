{{ config(materialized='ephemeral') }}
with listings as
(
    select 
        LISTING_ID,
        PROPERTY_TYPE,
        ROOM_TYPE,
        CITY,
        COUNTRY,
        ACCOMMODATES,
        BEDROOMS,
        BATHROOMS,
        PRICE_PER_NIGHT,
        PRICE_TAG,
        LISTING_CREATED_AT
    FROM {{ ref('obt') }}
)

select * from listings