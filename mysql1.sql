/*Table customers */
CREATE TABLE customers ( 
    customer_id   INT           PRIMARY KEY, 
    first_name    VARCHAR(50)   NOT NULL, 
    last_name     VARCHAR(50)   NOT NULL, 
    email         VARCHAR(100)  UNIQUE NOT NULL, 
    city          VARCHAR(50)   NOT NULL, 
    state         VARCHAR(50)   NOT NULL, 
    join_date     DATE          NOT NULL, 
    is_premium    BOOLEAN       DEFAULT FALSE 
); 
 
-- Index for filtering by city/state 
CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state); 
/*Table: products */
CREATE TABLE products ( 
    product_id    INT           PRIMARY KEY, 
    product_name  VARCHAR(100)  NOT NULL, 
    category      VARCHAR(50)   NOT NULL, 
    brand         VARCHAR(50)   NOT NULL, 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0) 
); 
 
-- Index for filtering by category 
CREATE INDEX idx_products_category ON products(category); 
/*Table: orders */
CREATE TABLE orders ( 
    order_id      INT           PRIMARY KEY, 
    customer_id   INT           NOT NULL, 
    order_date    DATE          NOT NULL, 
    status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending' 
                  CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')), 
    total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0), 
     
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 
 
-- Index for date-based filtering and sorting 
CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status); 
/*Table: order_items */ 
CREATE TABLE order_items ( 
    item_id       INT           PRIMARY KEY, 
    order_id      INT           NOT NULL, 
    product_id    INT           NOT NULL, 
    quantity      INT           NOT NULL  CHECK (quantity > 0), 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100), 
     
    FOREIGN KEY (order_id)   REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
); 


select * from customers;
select * from order_items;
select * from orders;
select * from products;

INSERT INTO customers VALUES 
(101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE), 
(102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE), 
(103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE), 
(104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE), 
(105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE), 
(106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE), 
(107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE), 
(108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE); 

select * from customers;
INSERT INTO products VALUES 
(201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250), 
(202, 'Cotton T-Shirt',       'Clothing',    'Levis',         799.00,  500), 
(203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150), 
(204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120), 
(205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200), 
(206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300), 
(207, 'Laptop Stand',         'Electronics', 'AmazonBasics',  899.00,  180), 
(208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',    599.00,  400); 

INSERT INTO orders VALUES 
(1001, 101, '2024-08-01', 'Delivered',  4498.00), 
(1002, 102, '2024-08-03', 'Delivered',  799.00), 
(1003, 103, '2024-08-05', 'Shipped',    7498.00), 
(1004, 101, '2024-08-10', 'Delivered',  3499.00), 
(1005, 104, '2024-08-12', 'Cancelled',  2999.00), 
(1006, 105, '2024-08-15', 'Delivered',  5898.00), 
(1007, 106, '2024-08-18', 'Pending',    1299.00), 
(1008, 103, '2024-08-20', 'Delivered',  899.00), 
(1009, 107, '2024-08-25', 'Shipped',    6098.00), 
(1010, 108, '2024-08-28', 'Delivered',  1598.00); 


INSERT INTO order_items VALUES 
(5001, 1001, 201, 2, 1499.00, 0), 
(5002, 1001, 207, 1, 899.00,  10), 
(5003, 1002, 202, 1, 799.00,  0), 
(5004, 1003, 203, 1, 2999.00, 0), 
(5005, 1003, 204, 1, 4599.00, 5), 
(5006, 1004, 205, 1, 3499.00, 0), 
(5007, 1005, 203, 1, 2999.00, 0), 
(5008, 1006, 201, 1, 1499.00, 10), 
(5009, 1006, 204, 1, 4599.00, 5), 
(5010, 1007, 206, 1, 1299.00, 0), 
(5011, 1008, 207, 1, 899.00,  0), 
(5012, 1009, 205, 1, 3499.00, 0), 
(5013, 1009, 208, 2, 599.00,  15), 
(5014, 1010, 206, 1, 1299.00, 0), 
(5015, 1010, 208, 1, 599.00,  0); 

select * from customers;
select * from order_items;
select * from orders;
select * from products;


/*Section A — SQL Basics (SELECT, Constraints, Primary Keys) 
These questions test your understanding of basic data retrieval, table structure,
 and database constraints. */
-- Q1. Write a query to display all columns and rows from the customer's table. 
select * from customers;

-- Q2. Retrieve only the first_name, last_name, and city of all customers. 
select first_name,last_name,city from customers;

-- Q3. List all unique categories available in the products table. 
select * from products;
select distinct category from products;

-- Q4. Identify the Primary Key of each table in the schema.
--  Explain why a Primary Key must be unique and NOT NULL. 
/* for customer table = customer_id
for order_items = item_id
fro orders = order_id
fro products = product_id
A Primary Key is used to identify each row in a table. 
It should be unique so that every record has a different ID. 
It should not be NULL because every record must have an ID. 
This helps the database store and find data correctly.*/

/* Q5. What constraints are applied to the email column in the customers table? 
NOT NULL – The email field cannot be left empty. Every customer must have an email address entered.
UNIQUE – No two customers can have the same email address. Every email must be different.
What would happen if you tried to insert a duplicate email? 
The database will not accept the new record.
An error message will appear saying that this email already exists.
The old data stays safe and no changes will be made.
This constraint is applied so that every customer has a unique identity in the system and wrong or repeated entries can be avoided in the database.*/

-- Q6. Try inserting a product with unit_price = -50.
-- What happens and which constraint prevents it? Write both the INSERT statement and explain the error.
insert into products (product_id, product_name, category, brand, unit_price, stock_qty)
VALUES (209, 'Iphone 17 Pro', 'Electronics', 'Apple', -50, 20);
/*In this query, an error occurs because the unit_price is -50, which violates the CHECK constraint (products_chk_1).
 When the products table was created, the constraint CHECK (unit_price > 0) was added. 
Since -50 is less than 0, the database rejects the record and displays an error.*/

-- SECTION- B 
-- Q7. Retrieve all orders with status = 'Delivered'. 
select * from orders where status = 'Delivered';

-- Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000. 
select * from products where category = 'Electronics' AND unit_price>2000;

-- Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'.
select * from customers where join_date between '2024-01-01' and '2024-12-31' and state = 'Maharashtra';

-- Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled.
select * from orders where order_date between '2024-08-10' and '2024-08-25' and status != 'cancelled';

-- Q11. Explain what the index idx_orders_date does. 
-- How would it improve the performance of a query that filters orders by order_date?
 -- Write a sample query that would benefit from this index. 
 -- The idx_orders_date index is used on the order_date column. 
 -- It helps the database find the required orders faster.
 -- Without the index, the database checks every row.
 -- With the index, it directly finds the matching records, so the query takes less time.;

select *from orders where  order_date = '2024-08-15';

-- Q12. If you run: SELECT * FROM customers WHERE YEAR(join_date) = 2024; 
-- would the index on join_date be used? 
-- Explain why or why not, and rewrite the query to be index-friendly (SARGable). 
SELECT * FROM customers WHERE YEAR(join_date) = 2024; 
/*The query YEAR(join_date) = 2024 is not index-friendly because the YEAR() function is applied to the join_date column. 
The database has to check every row, so the index is not used efficiently. 
The rewritten query uses a date range, which allows the database to use the index and return the results faster.*/
select * from customers where join_date >= '2024-01-01' and join_date < '2024-12-31';
-- Q13. Count the total number of orders in the orders table. 
select count(order_id) as total_orders from orders;

-- Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders. 
select SUM(total_amount) as total_revenue from orders where status='Delivered';

-- Q15. Calculate the average unit_price of products in each category. 
select avg(unit_price) as avg_price from products group by category;

-- Q16. For each order status, find the count of orders and the total revenue. 
-- Sort the result by total revenue in descending order. 
select count(order_id) as total_orders,SUM(total_amount) as total_revenue   from orders group by status
order by total_revenue;

-- Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category. 
select max(unit_price) as max_price , min(unit_price) as min_price from products;

-- Q18. List all product categories where the average unit_price is greater than ₹2000. 
-- (Hint: Use HAVING clause) 
select category , avg(unit_price) as avg_price from products group by category  having avg(unit_price) >2000;

-- 19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name.
select first_name , last_name , order_id from customers inner join orders on customers.customer_id=orders.customer_id; 
-- Show: order_id, order_date, first_name, last_name, total_amount. 
select orders.order_id,orders.order_date,customers.first_name,customers.last_name,orders.total_amount from customers inner join orders on customers.customer_id=orders.customer_id;

-- Q20. Using a LEFT JOIN, list ALL customers and their orders (if any). 
-- Customers with no orders should still appear with NULL values for order columns.
select customers.first_name, customers.last_name , orders.order_id from customers left join orders on customers.customer_id=orders.customer_id;

-- Q21. Write a query using JOINs across three tables (orders → order_items → products) 
-- to show: order_id, product_name, quantity, unit_price, and discount_pct for each order item. 

select orders.order_id,products.product_name,order_items.quantity,order_items.unit_price,order_items.discount_pct
from order_items inner join orders on order_items.order_id = orders.order_id inner join products
on order_items.product_id = products.product_id;

/* Q24. Write a query using CASE to classify products into price tiers: 
  • 'Budget'    → unit_price < 1000 
  • 'Mid-Range' → unit_price BETWEEN 1000 AND 3000 
  • 'Premium'   → unit_price > 3000 
Display: product_name, unit_price, price_tier. */

select product_name,unit_price,
	case
        when unit_price < 1000 then 'Budget'
        when unit_price between 1000 and 3000 then 'Mid-Range'
        when unit_price > 3000 then 'Premium'
    end as price_tier from products;

-- Q25. Using a CASE statement inside an aggregate function, count how many orders are 'Delivered' vs 'Not Delivered' (all other statuses).
--  Display the result in a single row. 

select sum(case when status = 'Delivered' then 1 else 0 end) as delivered_orders,
sum(case when status != 'Delivered' then 1 else 0 end) as not_delivered_orders from orders;

/*Q27. Write a SQL transaction that does the following atomically: 
  1. Insert a new order (order_id=1011, customer_id=102, today's date, 'Pending', 1598.00) 
  2. Insert two order items for that order 
  3. Update the stock_qty of the purchased products 
  4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT. 
Write the complete BEGIN...COMMIT/ROLLBACK block. */
start transaction;

-- step 1: insert new order
insert into orders values 
(1011, 102, curdate(), 'Pending', 1598.00);

-- step 2: insert two order items
insert into order_items values 
(5016, 1011, 206, 1, 1299.00, 0);

insert into order_items values 
(5017, 1011, 208, 1, 599.00, 0);

-- step 3: update stock quantity
update products 
set stock_qty = stock_qty - 1 
where product_id = 206;

update products 
set stock_qty = stock_qty - 1 
where product_id = 208;

-- step 4: commit
commit;


rollback;
