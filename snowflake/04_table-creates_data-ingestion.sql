USE WAREHOUSE ZOMATO_WH;
USE DATABASE ZOMATO;
USE SCHEMA RAW;


/* 01.============== Create Table 'food' & ingest data from s3 =================*/

CREATE OR REPLACE TABLE RAW.FOODS (
    _idx INTEGER,
    f_id STRING,
    iten STRING,
    veg_or_non_veg STRING
    )

COPY INTO FOODS
FROM @ZOMATO_RAW_STAGE/foods
ON_ERROR = CONTINUE
FILE_FORMAT = (FORMAT_NAME = CSV_FMT);

/* 02.============== Create Table 'manus' & ingest data from s3 =================*/
 

CREATE OR REPLACE TABLE RAW.MANUS (
    _idx STRING,
    manu_id STRING,
    r_id INTEGER,
    f_id STRING,
    cuisine STRING,
    price STRING
)

COPY INTO manus
FROM @ZOMATO_RAW_STAGE/manus
ON_ERROR = CONTINUE
FILE_FORMAT = (FORMAT_NAME = CSV_FMT);

 

/* 03.============== Create Table 'resturents' & ingest data from s3 =================*/


CREATE OR REPLACE TABLE RAW.resturents (
  _idx          STRING,                    -- leading index column in the CSV (ignored downstream)
  id            STRING, 
  name          STRING, 
  city          STRING, 
  rating        STRING,
  rating_count  STRING, 
  cost          STRING, 
  cuisine       STRING, 
  lic_no        STRING,
  link          STRING, 
  address       STRING, 
  menu          STRING
);

COPY INTO resturents
FROM @ZOMATO_RAW_STAGE/resturents
ON_ERROR = CONTINUE
FILE_FORMAT = (FORMAT_NAME = CSV_FMT);


 /* 04.============== Create Table 'reviews' & ingest data from s3 =================*/

 CREATE OR REPLACE TABLE RAW.reviews (
  review_id     NUMBER,
  order_id      NUMBER,
  user_id       NUMBER,
  restaurant_id NUMBER,
  rating        NUMBER,
  comment       STRING,
  review_date   DATE
);

COPY INTO reviews
FROM @ZOMATO_RAW_STAGE/reviews
ON_ERROR = CONTINUE
FILE_FORMAT = (FORMAT_NAME = CSV_FMT);


 /* 05.============== Create Table 'users' & ingest data from s3 =================*/

CREATE OR REPLACE TABLE RAW.users (
  _idx STRING,                             -- leading index column in the CSV
  user_id STRING, 
  name STRING, 
  email STRING, 
  password STRING, 
  age STRING,
  gender STRING, 
  marital_status STRING, 
  occupation STRING, 
  monthly_income STRING,
  education STRING, 
  family_size STRING
);

COPY INTO users
FROM @ZOMATO_RAW_STAGE/users
FILE_FORMAT = (FORMAT_NAME = CSV_FMT)
ON_ERROR = CONTINUE

 /* 05.============== Create Table 'orders' & ingest data from s3 =================*/



CREATE OR REPLACE TABLE RAW.orders (
  order_id          NUMBER,
  order_timestamp   TIMESTAMP_NTZ,
  order_date        DATE,
  user_id           NUMBER,
  r_id              NUMBER,
  restaurant_city   STRING,
  cuisine           STRING,
  items_count       NUMBER,
  sales_qty         NUMBER,
  subtotal          NUMBER,
  discount          NUMBER,
  delivery_fee      NUMBER,
  gst               NUMBER,
  sales_amount      NUMBER,
  currency          STRING,
  payment_method    STRING,
  order_status      STRING,
  customer_rating   NUMBER,
  delivery_time_min NUMBER
);

COPY INTO orders
FROM @ZOMATO_RAW_STAGE/orders
FILE_FORMAT = (FORMAT_NAME = CSV_FMT)
ON_ERROR = CONTINUE

 /* 05.============== Create Table 'order_items' & ingest data from s3 =================*/

 CREATE OR REPLACE TABLE RAW.order_items (
  order_item_id NUMBER,
  order_id      NUMBER,
  r_id          NUMBER,
  f_id          STRING,
  price         NUMBER,
  quantity      NUMBER,
  line_amount   NUMBER
);

COPY INTO order_items
FROM @ZOMATO_RAW_STAGE/order_items
FILE_FORMAT = (FORMAT_NAME = CSV_FMT)
ON_ERROR = CONTINUE


SELECT 'RESTUNRENT' t, COUNT(*) n FROM RAW.RESTURENTS
UNION ALL SELECT 'FOOD', COUNT(*) FROM RAW.FOODS
UNION ALL SELECT 'USERS', COUNT(*) FROM RAW.USERS
UNION ALL SELECT 'MENUS', COUNT(*) FROM RAW.MANUS
UNION ALL SELECT 'ORDERS', COUNT(*) FROM RAW.ORDERS
UNION ALL SELECT 'ORDER_ITEMS', COUNT(*) FROM RAW.ORDER_ITEMS
UNION ALL SELECT 'REVIEWS', COUNT(*) FROM RAW.REVIEWS


 select * from resturents

 show schemas

 select * from zomato.staging.stg_restaurants limit 100;
 select * from zomato.mart.dim_restaurants limit 100;
 drop table zomato.mart.dim_restaurants

 show tables
 select TOP 10 * from zomato.raw.manus
