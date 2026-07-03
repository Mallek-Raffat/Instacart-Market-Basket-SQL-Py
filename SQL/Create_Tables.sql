use instacart
go
CREATE TABLE order_products_prior (
    order_id int NOT NULL,
    product_id  int NOT NULL,
    add_to_cart_order SMALLINT NOT NULL,
    reordered BIT NOT NULL
);

use instacart
go
BULK INSERT order_products_prior
FROM 'D:\data science\Project\Instacart Market Basket Analysis\Datasets\order_products__prior.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);





BULK INSERT dbo.products
FROM 'C:\temp\test.csv'
WITH (
FIRSTROW=2,
FIELDTERMINATOR=',',
ROWTERMINATOR='\n'
);