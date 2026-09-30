-- CREATE DATABSE
CREATE DATABASE AIRBNB;
CREATE SCHEMA AIRBNB.STAGING;
USE ROLE ACCOUNTADMIN;

-- CREATE A CSV FILE FORMAT
CREATE FILE FORMAT If NOT EXISTS CSV_FORMAT
    TYPE = CSV
    COMPRESSION = AUTO
    FIELD_DELIMITER = ','    
    SKIP_HEADER = 1
    DATE_FORMAT = AUTO
    TIME_FORMAT = AUTO
    EMPTY_FIELD_AS_NULL = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '\042' -- \042 represents double quotes (")
    NULL_IF = ('NULL', 'null', '')
    ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE;

-- CREATE STAGE
create or replace stage s3_stage
url  = 's3://amzn-s3-airbnb-data-dev/source/'
credentials = (
    AWS_KEY_ID = 'XXXXXXXXXXXXXXXX'
    AWS_SECRET_KEY = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    )
file_format = csv_format;

list @s3_stage;

-- Loading Books Data
COPY INTO BOOKINGS
FROM @S3_STAGE
FILES = ('bookings.csv')
;

-- Loading Hosts Data
COPY INTO HOSTS
FROM @S3_STAGE
FILES = ('hosts.csv')
;

-- Loading Listings Data
COPY INTO LISTINGS
FROM @S3_STAGE
FILES = ('listings.csv')
;