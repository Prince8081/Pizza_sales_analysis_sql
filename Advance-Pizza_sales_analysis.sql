									  -- Advance_Level -- 

									-- Q.1 --
SELECT 
    pizza_types.category,
    ROUND((SUM(order_details.quantity * pizzas.price) / (SELECT 
                    SUM(order_details.quantity * Pizzas.price) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id)),
            4) * 100 AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY Revenue DESC;                                    


                                 -- Q.2 --
select order_date, sum(Revenue) over(order by  order_date) as Cum_Revenue 
from 
(select orders.order_date, sum(order_details.quantity*pizzas.price) as Revenue 
from orders join order_details on orders.order_id = order_details.order_id 
join pizzas on pizzas.pizza_id = order_details.pizza_id  
group by orders.order_date ) as sales;


                                -- Q.3 -- 
select name , Revenue 
from 
(select category , name, Revenue , 
Rank() over(partition by category order by revenue desc) as Rn 
from 
(select pizza_types.category , pizza_types.name ,sum(order_details.quantity*pizzas.price ) as Revenue 
from pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id join order_details
on pizzas.pizza_id = order_details.pizza_id 
group by pizza_types.category , pizza_types.name) as a ) as b
where Rn <= 3;     

                           