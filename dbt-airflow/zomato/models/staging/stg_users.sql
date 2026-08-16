SELECT
    user_id::NUMBER AS customer_id,
    TRIM(name) AS customer_name,
    LOWER(email) AS email,
    TRY_TO_NUMBER(age) AS age,
    TRIM(gender) AS gender, 
    TRIM(marital_status) AS marital_status, 
    TRIM(occupation) AS occupation,
    TRIM(monthly_income) AS income_band, 
    TRIM(education) AS education, 
    TRY_TO_NUMBER(family_size) AS family_size

FROM {{ source('raw', 'users') }}
WHERE TRY_TO_NUMBER(user_id) IS NOT NULL

