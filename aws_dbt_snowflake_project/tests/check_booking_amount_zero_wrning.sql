{{ config(
    severity='warn',
    tags=['booking_amount_zero']
) }}

select 
    1
from {{ source('STAGING', 'BOOKINGS') }}
where booking_amount < 200