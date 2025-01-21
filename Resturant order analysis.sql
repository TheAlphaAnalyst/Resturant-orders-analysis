USE restaurant_db;

-- View the menu_items table

SELECT *
FROM menu_items;

-- find the number of items on the table

SELECT COUNT(*)
FROM menu_items;

-- there are a total of 32 items on the menu_items table

-- what are the least and most expensive items on the menu?

SELECT item_name, MIN(price), MAX(price)
FROM menu_items
GROUP BY item_name;

SELECT *
FROM menu_items
ORDER BY price;

SELECT *
FROM menu_items
ORDER BY price DESC;

-- how many italian dishes are on the menu?
SELECT *
FROM menu_items;

SELECT category, COUNT(*)
FROM menu_items
WHERE category = "Italian";


-- what are the least and most expensive italian dishes on the menu?

SELECT item_name, MIN(price), MAX(price)
FROM menu_items
WHERE category = "Italian"
GROUP BY item_name;


SELECT *
FROM menu_items
WHERE category = "italian"
ORDER BY price;


SELECT *
FROM menu_items
WHERE category = "italian"
ORDER BY price DESC;

-- how many dishes are in each category?

SELECT *
FROM menu_items;

SELECT category, COUNT(item_name) Dish_in_category
FROM menu_items
GROUP BY category;


-- what is the average sum price in each category?

SELECT *
FROM menu_items;

SELECT Category, AVG(price) AS Average_price
FROM menu_items
GROUP BY Category
ORDER BY Average_price DESC;




-- EXPLORE ORDERS TABLE


-- View the orders_detail table

SELECT * 
FROM order_details;

-- what is the date range of the table?

SELECT *
FROM order_details
ORDER BY order_date;

SELECT MIN(order_date), MAX(order_date)
FROM order_details;


-- how many orders were made between this date range?

SELECT *
FROM order_details;

SELECT COUNT(DISTINCT Order_id) Total_orders_made
FROM order_details;


-- how many items were ordered within this date range?

SELECT *
FROM order_details;

SELECT COUNT(DISTINCT item_id) Total_items_ordered
FROM order_details;

SELECT COUNT(*)
FROM order_details;


-- which orders have the most number of items?

SELECT *
FROM order_details;

SELECT order_id, COUNT(item_id) Order_num
FROM order_details
GROUP BY order_id
ORDER BY order_num DESC;


-- How mnay orders have more than 12 items?


WITH Order_num AS
(
SELECT order_id, COUNT(item_id) Order_num
FROM order_details
GROUP BY order_id
HAVING Order_num > 12
ORDER BY order_num DESC
)
SELECT COUNT(*)
FROM Order_num;



-- OBJECTIVE 3 ANALYZE CUSTOMER BEHAVIOUR

-- Combine the menu_items table and the order_details table into a single table 

SELECT *
FROM menu_items;

SELECT *
FROM order_details;

SELECT *
FROM menu_items
JOIN order_details
ON menu_item_id = item_id;

-- What were the least and most ordered items? What categories were they in ?


WITH Joined_table AS
(
SELECT *
FROM menu_items
JOIN order_details
ON menu_item_id = item_id
)
SELECT item_name, Category, COUNT(order_id) order_num
FROM Joined_table
GROUP BY item_name, category
ORDER BY order_num DESC;
;

-- What were the top 5 orders that spent the most money?

WITH Joined_table AS (
SELECT *
FROM menu_items
JOIN order_details
ON menu_item_id = item_id)
SELECT order_id, SUM(price) Total_money_spent
FROM Joined_table
GROUP BY order_id
ORDER BY Total_money_spent DESC
LIMIT 5;

-- View the details of the highest spent order, what insights can you gather from there?

SELECT *
FROM menu_items
JOIN order_details
ON menu_item_id = item_id
WHERE order_id = 440;

SELECT category, COUNT(item_id)
FROM menu_items
JOIN order_details
ON menu_item_id = item_id
WHERE order_id = 440
GROUP BY category;

-- order 440 being the hughest spender ordered 8 italian dishes
-- this is more than half of the total order of 14
-- the person is probably italian


-- View the details of the top 5 highest spent orders, what insights can you gather from ther0e?

SELECT order_id, category, COUNT(item_id)
FROM menu_items
JOIN order_details
ON menu_item_id = item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY category, order_id;


-- The highest spenders spend a lot on italian foods