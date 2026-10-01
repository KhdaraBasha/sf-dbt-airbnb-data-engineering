-- If Cuase We can also use the if clause to filter the data based on a condition. For example, we can filter the data based on the number of nights booked. If the number of nights booked is greater than 2, we will return the data, otherwise we will return an empty result set.
{% set nights_booked = 2 %}

{% if nights_booked == 2 %}
    select * from {{ ref('bronze_bookings') }} 
    where nights_booked = {{ nights_booked }}
    limit 10
{% else %}
    select * from {{ ref('bronze_bookings') }} 
    where 1=0
{% endif %}