							--  Intermediate_Level --
                            
                                -- Q.1 --
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS Total_Qty
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY Total_Qty DESC;


							  -- Q.2 --
SELECT 
    HOUR(order_time) AS Hour, COUNT(order_id) AS Total_order
FROM
    orders
GROUP BY hour
ORDER BY Total_order DESC;


                             -- Q.3 --
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;


                             -- Q.4 --
SELECT 
    ROUND(AVG(Qty), 0) AS Avg_order_perday
FROM
    (SELECT 
        orders.order_date AS Date,
            SUM(order_details.quantity) AS Qty
    FROM
        orders
    JOIN order_details ON order_details.order_id = orders.order_id
    GROUP BY Date) AS order_quantity;
 

                             -- Q.5 --
SELECT 
    pizza_types.name,
    SUM(pizzas.price * order_details.quantity) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC
LIMIT 3;

