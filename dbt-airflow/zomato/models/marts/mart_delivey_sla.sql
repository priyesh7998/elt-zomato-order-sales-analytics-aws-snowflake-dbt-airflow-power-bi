SELECT    
    city, 
    hour(order_timestamp) as order_hour, 
    count_if(is_delivered) as delivered_orders,
    round(median(delivery_time_min),1) as p50, 
    round(percentile_cont(0.9) within group (order by delivery_time_min),1) as p90
FROM {{ ref('fct_orders') }} 
WHERE is_delivered GROUP BY city,hour(order_timestamp)