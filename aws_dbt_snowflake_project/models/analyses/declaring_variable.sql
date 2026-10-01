-- Filtering bookings with more than 2 nights booked
-- declaring a variable for the number of nights booked

{% set nights_booked = 2 %}

select * from {{ ref('bronze_bookings') }} 
where nights_booked > {{ nights_booked }}
limit 10