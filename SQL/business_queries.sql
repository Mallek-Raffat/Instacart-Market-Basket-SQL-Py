---TOP 10 Top Selling Products

select top 10 p.product_name, count(opp.order_id)as 'Top_Selling_Products'
from order_products_prior opp
join products p
on p.product_id=opp.product_id
group by p.product_name
order by COUNT(opp.order_id) Desc



---TOP 10 Top Selling Department

select top 10 d.department, count(opp.order_id)as 'Top_Selling_Department'
from order_products_prior opp
join products p
on p.product_id=opp.product_id
join departments d
on d.department_id=p.department_id
group by d.department
order by COUNT(opp.order_id) Desc




---TOP 10 Top Selling Aisles

select top 10 a.aisle, count(opp.order_id)as 'Top_Selling_Aisles'
from order_products_prior opp
join products p
on p.product_id=opp.product_id
join departments d
on d.department_id=p.department_id
join aisles a
on a.aisle_id=p.aisle_id
group by a.aisle
order by COUNT(opp.order_id) Desc


---Most_Reordered_Products

select product_name, sum(opp.reordered)as 'Most_Reordered_Products'
from order_products_prior opp
join products p
on p.product_id=opp.product_id
group by p.product_name
order by sum(opp.reordered) Desc


---Average Basket Size
SELECT
    AVG(basket_size)
FROM
(
    SELECT
        order_id,
        COUNT(*) AS basket_size
    FROM order_products_prior
    GROUP BY order_id
) AS basket;


-- Customers With Highest Orders
SELECT
    user_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY user_id
ORDER BY total_orders DESC;


-- Peak Shopping Hours
SELECT
    order_hour_of_day,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY total_orders DESC;


-- Peak Shopping Days
SELECT
    order_dow,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_dow
ORDER BY total_orders DESC;


-- Department Reorder Rate
SELECT
    d.department,
    CAST(
        100.0 * SUM(CAST(opp.reordered AS INT))
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS reorder_rate
FROM order_products_prior opp
JOIN products p
    ON opp.product_id = p.product_id
JOIN departments d
    ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY reorder_rate DESC;


-- Product Reorder Rate
SELECT
    p.product_name,
    CAST(
        100.0 * SUM(CAST(opp.reordered AS INT))
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS reorder_rate
FROM order_products_prior opp
JOIN products p
    ON opp.product_id = p.product_id
GROUP BY p.product_name
ORDER BY reorder_rate DESC;


-- Average Days Between Orders
SELECT
    AVG(days_since_prior_order) AS average_days_between_orders
FROM orders
WHERE days_since_prior_order IS NOT NULL;


-- Customer Lifetime Orders
SELECT
    user_id,
    MAX(order_number) AS lifetime_orders
FROM orders
GROUP BY user_id
ORDER BY lifetime_orders DESC;


-- Average Products Per Customer
SELECT
    AVG(products_per_customer) AS average_products_per_customer
FROM
(
    SELECT
        o.user_id,
        COUNT(*) AS products_per_customer
    FROM orders o
    JOIN order_products_prior opp
        ON o.order_id = opp.order_id
    GROUP BY o.user_id
) AS customer_products;


-- Top Repeat Customers
SELECT
    o.user_id,
    SUM(CAST(opp.reordered AS INT)) AS reordered_products
FROM orders o
JOIN order_products_prior opp
    ON o.order_id = opp.order_id
GROUP BY o.user_id
ORDER BY reordered_products DESC;
