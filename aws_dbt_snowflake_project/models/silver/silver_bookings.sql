{{ config(materialized='incremental', unique_key = 'BOOKING_ID') }}

select 
    b.BOOKING_ID,
    b.LISTING_ID,
    b.BOOKING_DATE,
    b.NIGHTS_BOOKED,
    b.BOOKING_AMOUNT,
    b.CLEANING_FEE,
    b.SERVICE_FEE,
    -- 1. FIXED: Removed single quotes around column arguments
    {{ multiply_numbers('NIGHTS_BOOKED', 'BOOKING_AMOUNT', 2) }} + {{ add_numbers('CLEANING_FEE', 'SERVICE_FEE', 2) }} as TOTAL_BOOKING_AMOUNT,
    b.BOOKING_STATUS,
    b.CREATED_AT
from {{ ref('bronze_bookings') }} as b

{% if is_incremental() %}
    -- 2. FIXED: Removed 'b.' alias from inside the subquery
    where b.CREATED_AT > (select coalesce(max(CREATED_AT), '1970-01-01'::date) from {{ this }})
{% endif %}
