SELECT 
    f.restaurant_id, 
    r.restaurant_name, 
    r.city, 
    r.cuisine, 
    COUNT(*) as orders,
    SUM(iff(f.is_delivered, f.sales_amount, 0)) as revenue, 
    ROUND(AVG(f.customer_rating),2) as avg_customer_rating,
    ROUND(AVG(f.delivery_time_min),1) as avg_delivery_min
FROM {{ ref('fct_orders') }} f 
LEFT JOIN {{ ref('dim_restaurants') }} r USING (restaurant_id) 
GROUP BY   f.restaurant_id, r.restaurant_name, r.city, r.cuisine