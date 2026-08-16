SELECT
    f_id,
    TRIM(iten) AS food_name,
    INITCAP(TRIM(veg_or_non_veg)) AS veg_or_non_veg

FROM {{ source('raw', 'foods') }}
WHERE f_id IS NOT NULL

