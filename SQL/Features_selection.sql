CREATE VIEW reordered_classification_dataset AS
WITH user_features AS
(
    SELECT
        o.user_id,
        COUNT(DISTINCT o.order_id) AS total_orders_for_user,
        AVG(o.days_since_prior_order) AS average_days_between_orders,
        AVG(order_size.basket_size) AS average_basket_size,
        CAST(
            SUM(CAST(opp.reordered AS FLOAT))
            / COUNT(*) AS DECIMAL(5,4)
        ) AS user_reorder_rate
    FROM orders o
    JOIN order_products_prior opp
        ON o.order_id = opp.order_id
    JOIN
    (
        SELECT
            order_id,
            COUNT(*) AS basket_size
        FROM order_products_prior
        GROUP BY order_id
    ) order_size
        ON order_size.order_id = o.order_id
    GROUP BY o.user_id
),

product_features AS
(
    SELECT
        product_id,
        COUNT(*) AS product_popularity,
        CAST(
            SUM(CAST(reordered AS FLOAT))
            / COUNT(*) AS DECIMAL(5,4)
        ) AS product_reorder_rate
    FROM order_products_prior
    GROUP BY product_id
),

department_features AS
(
    SELECT
        p.department_id,
        CAST(
            SUM(CAST(opp.reordered AS FLOAT))
            / COUNT(*) AS DECIMAL(5,4)
        ) AS department_reorder_rate
    FROM order_products_prior opp
    JOIN products p
        ON p.product_id = opp.product_id
    GROUP BY p.department_id
),

aisle_features AS
(
    SELECT
        p.aisle_id,
        CAST(
            SUM(CAST(opp.reordered AS FLOAT))
            / COUNT(*) AS DECIMAL(5,4)
        ) AS aisle_reorder_rate
    FROM order_products_prior opp
    JOIN products p
        ON p.product_id = opp.product_id
    GROUP BY p.aisle_id
)

SELECT

    o.user_id,
    o.order_id,
    o.order_number,
    o.order_dow,
    o.order_hour_of_day,
    o.days_since_prior_order,

    p.product_id,
    p.product_name,

    d.department,
    a.aisle,

    opp.add_to_cart_order,

    uf.total_orders_for_user,
    uf.user_reorder_rate,
    uf.average_basket_size,

    pf.product_popularity,
    pf.product_reorder_rate,

    df.department_reorder_rate,

    af.aisle_reorder_rate,

    opp.reordered

FROM orders o

JOIN order_products_prior opp
    ON opp.order_id = o.order_id

JOIN products p
    ON p.product_id = opp.product_id

JOIN departments d
    ON d.department_id = p.department_id

JOIN aisles a
    ON a.aisle_id = p.aisle_id

JOIN user_features uf
    ON uf.user_id = o.user_id

JOIN product_features pf
    ON pf.product_id = p.product_id

JOIN department_features df
    ON df.department_id = p.department_id

JOIN aisle_features af
    ON af.aisle_id = p.aisle_id;


use Instacart
go

CREATE VIEW reordered_classification_dataset_sample AS

SELECT *
FROM reordered_classification_dataset
WHERE order_id IN
(
    SELECT TOP (50000) order_id
    FROM orders
    ORDER BY NEWID()
)
AND days_since_prior_order IS NOT NULL;

CREATE VIEW Customer_segmentation_dataset AS

WITH selected_users AS
(
    SELECT TOP (5000)
        user_id
    FROM orders
    GROUP BY user_id
    ORDER BY NEWID()
)

SELECT
    o.user_id,
    o.order_id,
    p.product_id,

    o.order_number,
    o.order_dow,
    o.order_hour_of_day,
    o.days_since_prior_order,

    opp.add_to_cart_order,
    opp.reordered,

    p.product_name,
    d.department,
    a.aisle

FROM selected_users su

JOIN orders o
    ON su.user_id = o.user_id

JOIN order_products_prior opp
    ON o.order_id = opp.order_id

JOIN products p
    ON p.product_id = opp.product_id

JOIN departments d
    ON d.department_id = p.department_id

JOIN aisles a
    ON a.aisle_id = p.aisle_id

WHERE o.days_since_prior_order IS NOT NULL;

select *
from Customer_segmentation_dataset