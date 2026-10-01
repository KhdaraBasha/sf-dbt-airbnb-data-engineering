
select 
    *
from {{ ref('bronze_hosts') }}
limit 100