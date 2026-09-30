-- 
use warehouse compute_wh;
use role accountadmin;
use database airbnb;
use schema airbnb.staging;

-- Airbmb Tables

-- create hosts table
create or replace table hosts 
    (
        host_id number,
        host_name string,
        host_since date,
        is_superhost boolean,
        response_rate number,
        created_at timestamp,
        primary key(host_id)
    );

-- create listings table
create or replace table listings
    (
        listing_id number,
        host_id number,
        property_type string,
        room_type string,
        city string,
        country string,
        accommodates number,
        bedrooms number,
        bathrooms number,
        price_per_night number,
        created_at timestamp,
        primary key(listing_id)
    );

-- create bookings table
create or replace table bookings
    (
        booking_id string,
        listing_id number,
        booking_date date,
        nights_booked number,
        booking_amount number,
        cleaning_fee number,
        service_fee number,
        booking_status string,
        created_at timestamp,
        primary key(booking_id)
    );