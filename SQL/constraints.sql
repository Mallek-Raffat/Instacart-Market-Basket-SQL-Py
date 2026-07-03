USE Instacart;
GO

-- ==========================
-- Departments
-- ==========================
CREATE TABLE departments (
    department_id INT NOT NULL PRIMARY KEY,
    department NVARCHAR(100) NOT NULL
);

-- ==========================
-- Aisles
-- ==========================
CREATE TABLE aisles (
    aisle_id INT NOT NULL PRIMARY KEY,
    aisle NVARCHAR(150) NOT NULL
);
ALTER TABLE aisles
ALTER COLUMN aisle_id INT NOT NULL;
-- ==========================
-- Products
-- ==========================
CREATE TABLE products (
    product_id INT NOT NULL PRIMARY KEY,
    product_name NVARCHAR(255) NOT NULL,
    aisle_id INT NOT NULL,
    department_id INT NOT NULL
);

-- ==========================
-- Orders
-- ==========================
CREATE TABLE orders (
    order_id INT NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    eval_set NVARCHAR(10) NOT NULL,
    order_number INT NOT NULL,
    order_dow TINYINT NOT NULL,
    order_hour_of_day TINYINT NOT NULL,
    days_since_prior_order FLOAT NULL
);

-- ==========================
-- Order Products Prior
-- ==========================
CREATE TABLE order_products_prior (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    add_to_cart_order SMALLINT NOT NULL,
    reordered BIT NOT NULL
);

-- ==========================
-- Order Products Train
-- ==========================
CREATE TABLE order_products_train (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    add_to_cart_order SMALLINT NOT NULL,
    reordered BIT NOT NULL
);


