{% set cols = ['booking_id', 'booking_date', 'nights_booked', 'booking_status', 'booking_amount'] %}

select
    {% for col in cols %}
    {{ col }}{% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('bronze_bookings') }}
limit 10