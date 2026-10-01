
select 
        CLEANING_FEE, 
        SERVICE_FEE
        ,{{ add_numbers('CLEANING_FEE', 'SERVICE_FEE', 2) }} as total_fees 
        ,{{ multiply_numbers('CLEANING_FEE', 'SERVICE_FEE', 2) }} as total_fees_multiplication

from {{ ref('bronze_bookings') }}