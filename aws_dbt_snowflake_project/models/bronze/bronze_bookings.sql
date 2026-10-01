{# {% set incremental_flag = 1 %}
{% set incremental_key = 'CREATED_AT' %} #}
{{ config(materialized='incremental') }}

select * from {{ source('STAGING', 'BOOKINGS') }}

{% if is_incremental() %}
where CREATED_AT > (select coalesce(max(CREATED_AT), '1970-01-01') from {{ this }})
{% endif %}