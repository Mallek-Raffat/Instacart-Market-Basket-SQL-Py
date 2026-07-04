create view vw_products_details as
select p.product_id, p.product_name ,a.aisle ,d.department
from products p
join aisles a
on a.aisle_id=p.aisle_id
join departments d
on d.department_id=p.department_id

create view vw_user_details as
select o.user_id ,p.product_name,opp.reordered,o.order_id
from orders o
join order_products_prior opp
on o.order_id=opp.order_id
join products p
on p.product_id =opp.product_id


create view order_details as
select o.order_id,o.user_id,p.product_name,a.aisle,d.department,opp.reordered,opp.add_to_cart_order
from orders o
join order_products_prior opp
on opp.order_id=o.order_id
join products p
on opp.product_id=p.product_id
join departments d
on d.department_id=p.department_id
join aisles a
on a.aisle_id=p.aisle_id


create view vw_customer_purchase_history as
SELECT
    o.user_id,
    COUNT( o.order_id) AS number_of_orders_by_user,
    COUNT( p.product_id) AS number_of_products_by_user
FROM orders o
INNER JOIN order_products_prior opp
    ON o.order_id = opp.order_id
INNER JOIN products p
    ON opp.product_id = p.product_id
GROUP BY o.user_id;



CREATE VIEW vw_department_sales_summary AS
SELECT
    d.department_id,
    d.department,
    COUNT(opp.order_id) AS total_orders,
    COUNT(p.product_id) AS total_products,
    SUM(CASE
            WHEN opp.reordered = 1 THEN 1
            ELSE 0
        END) AS total_reorders
FROM departments d
JOIN products p
    ON d.department_id = p.department_id
JOIN order_products_prior opp
    ON p.product_id = opp.product_id
GROUP BY
    d.department_id,
    d.department;




create view user_behavior as
WITH BasketSize AS
(
    SELECT
        o.user_id,
        AVG(products_per_order) AS average_basket_size
    FROM
    (
        SELECT
            o.user_id,
            o.order_id,
            COUNT(*) AS products_per_order
        FROM orders o
        JOIN order_products_prior opp
            ON o.order_id = opp.order_id
        GROUP BY
            o.user_id,
            o.order_id
    ) t
    JOIN orders o
        ON t.user_id = o.user_id
    GROUP BY o.user_id
),

OrderFeatures AS
(
    SELECT
        user_id,
        AVG(days_since_prior_order) AS average_days_between_orders,
        AVG(order_hour_of_day) AS average_order_hour,
        COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY user_id
)

SELECT
    o.user_id,
    b.average_basket_size,
    o.average_days_between_orders,
    o.average_order_hour,
    o.total_orders
FROM OrderFeatures o
JOIN BasketSize b
    ON o.user_id = b.user_id
;


create view product_popularity as
select p.product_name,count(p.product_name) as 'total purchases', sum(opp.reordered) as 'total reordereds',(100*sum(opp.reordered)/COUNT(opp.reordered)) as 'reordereds rate %'
from products p
join order_products_prior opp
on opp.product_id=p.product_id
group by p.product_name









