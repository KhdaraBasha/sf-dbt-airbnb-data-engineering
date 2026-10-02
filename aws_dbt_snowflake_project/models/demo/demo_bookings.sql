{{
  config(
    materialized = 'table',
    )
}}

SELECT * FROM AIRBNB.STAGING.bookings