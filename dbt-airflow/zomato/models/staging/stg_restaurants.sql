-- Parse the messy dimension data from the raw table and create a clean dimension table for restaurants.


select
    id::NUMBER AS restaurant_id, 
    TRIM(name) AS restaurant_name,
    TRIM(COALESCE(REGEXP_SUBSTR(city, '[^,]+$'), city)) AS city,
    TRY_TO_DECIMAL(NULLIF(TRIM(rating), '--'), 3, 1) AS rating,
    TRY_TO_NUMBER(REGEXP_SUBSTR(rating_count, '[0-9]+')) AS rating_count,
    TRY_TO_NUMBER(REGEXP_SUBSTR(cost, '[0-9]+')) AS cost_for_two,
    TRIM(cuisine) AS cuisine,
    TRIM(lic_no) AS license_no
from {{ source('raw','resturents') }} WHERE id IS NOT NULL





