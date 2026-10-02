{% set configs = [
    {
        "table": "AIRBNB.GOLD.OBT",
        "columns": "GOLD_OBT.HOST_ID, GOLD_OBT.LISTING_ID, GOLD_OBT.BOOKING_ID, GOLD_OBT.TOTAL_BOOKING_AMOUNT, GOLD_OBT.CLEANING_FEE, GOLD_OBT.SERVICE_FEE, GOLD_OBT.NIGHTS_BOOKED",
        "alias": "GOLD_OBT"
    }
] %}

select 
   {% for config in configs %}
       {{ config.columns }}{% if not loop.last %}, {% endif %}
   {% endfor %}
from 
    {{ configs[0].table }} as {{ configs[0].alias }}