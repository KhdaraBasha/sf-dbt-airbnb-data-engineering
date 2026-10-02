{{ config(materialized='ephemeral') }}
with hosts as
(
    select distinct
        HOST_ID,
        HOST_NAME,
        HOST_SINCE,
        HOST_MONTHS_ACTIVE,
        HOST_AGE_BUCKET,
        IS_SUPERHOST,
        RESPONSE_RATE,
        RESPONSE_RATE_CLASS,
        HOST_CREATED_AT
    FROM {{ ref('obt') }}
)
select * from hosts