SELECT 
    manu_id,
    TRY_TO_DECIMAL(r_id) AS r_id,
    f_id,
    TRIM(cuisine) AS cuisine,
    try_to_decimal(price,10,2) as price

FROM {{ source('raw', 'manus') }}
WHERE TRY_TO_DECIMAL(r_id) IS NOT NULL 
AND 
try_to_decimal(price,10,2) > 0
 