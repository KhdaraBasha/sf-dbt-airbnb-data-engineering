{% set configs = [
    {
        "table": "AIRBNB.SILVER.SILVER_BOOKINGS",
        "columns": "SB.*",
        "alias": "SB"
    },
    {
        "table": "AIRBNB.SILVER.SILVER_LISTINGS",
        "columns": "SL.HOST_ID, SL.PROPERTY_TYPE, SL.ROOM_TYPE, SL.CITY, SL.COUNTRY, SL.ACCOMMODATES, SL.BEDROOMS, SL.BATHROOMS, SL.PRICE_PER_NIGHT, SL.PRICE_TAG, SL.CREATED_AT AS LISTING_CREATED_AT",
        "alias": "SL",
        "join_condition": "SB.LISTING_ID = SL.LISTING_ID"
    },
    {
        "table": "AIRBNB.SILVER.SILVER_HOSTS",
        "columns": "SH.HOST_NAME, SH.HOST_SINCE, SH.HOST_MONTHS_ACTIVE,SH.HOST_AGE_BUCKET, SH.IS_SUPERHOST, SH.RESPONSE_RATE, SH.RESPONSE_RATE_CLASS, SH.CREATED_AT AS HOST_CREATED_AT",
        "alias": "SH",
        "join_condition": "SL.HOST_ID = SH.HOST_ID"
    }
] %}

select 
   {% for config in configs %}
       {{ config.columns }}{% if not loop.last %}, {% endif %}
   {% endfor %}
from 
    {{ configs[0].table }} as {{ configs[0].alias }}
    {% for config in configs[1:] %}
        left join {{ config.table }} as {{ config.alias }}
        on {{ config.join_condition }}
    {% endfor %}