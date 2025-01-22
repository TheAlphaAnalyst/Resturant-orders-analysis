RESTURANT ORDER ANALYSIS

OBJECTIVES
•	Determine what the least and the most ordered items are and the category they belong to
•	Tell what the highest spend orders look like and how much they spent
•	Tell if there were certain times which had more or less orders
•	Determine which cuisine should be focused on developing more menu item on based on the data

STEPS
•	Explore the menu_items table
•	Explore the order_details table
•	Analyze customers behavior


STEP 1: EXPLORATION OF THE MENU_ITEMS TABLE
ACTIVITY 1
View the menu_item table
I used the SELECT * FROM menu_item command to pull all the data from the menu_items table

ACTIVITY 2
Find the number of items on the table
I used the SELECT COUNT(*) FROM menu_items table to count the items on the table. There were 32 items in total

ACTIVITY 3
Find the least and most expensive items on the table
I used SELECT item_name, MIN(price), FROM menu_items GROUP BY item_name; to find the least expensive item and SELECT item_name, MAX(price) FROM menu_items GROUP BY item_name; to find the most expensive item
I can also use SELECT item_name, price FROM menu_items ORDER BY price ASC LIMIT 1; to find the least expensive and SELECT item_name, price FROM menu_items ORDER BY price DESC LIMIT 1; for the most expensive

ACTIVITY 4
How many Italian foods are on the menu?
	
I used SELECT category, COUNT(*) FROM menu_items WHERE category = "Italian"; to get the number of Italian foods on the menu. There were 9 italian foods

ACTIVITY 5
Find the most expensive and least expensive Italian dishes on the menu

I used SELECT item_name, price FROM menu_items WHERE category = "italian" ORDER BY price DESC; to find the most expensive dish and SELECT item_name, price FROM menu_items WHERE category = "italian" ORDER BY price DESC; to find the least expensive dish. The most expensive dish is shrimp sxampi whuch sells for $19.95 and the least expensive fettucoine alfredo which sells for $14.50. 

I can also use SELECT item_name, MIN(price) FROM menu_items WHERE category = "Italian" GROUP BY item_name LIMIT 1; to find the least expensive Italian dish and SELECT item_name, MIN(price) FROM menu_items WHERE category = "Italian" GROUP BY item_name LIMIT 1; to find the most expensive dish.

ACTIVITY 6
Find the number of  dishes in each category in the menu list

I used SELECT category, COUNT(item_name) Dish_in_category FROM menu_items GROUP BY category GROUP BY Dish_in_category DESC; 
Mexican	9
Italian	9
Asian	8
American	6

ACTIVITY 7
Find the average sum price of each category

I used SELECT Category, AVG(price) AS Average_price FROM menu_items GROUP BY Category ORDER BY Average_price DESC;


STEP 2
ACTIVITY 1
View the order_details table

Using SELECT * FROM order_details; I pilled up all the data in the order_details tablre

ACTIVITY 2
Find the date range of the orders

The date range means the start date of the orders and the end date
Using SELECT MIN(order_date), MAX(order_date) FROM order_details; I got the start date to be 01/01/2023 and the end date to be 31/3/2023. This means that this all orders were made betweens these dates.

ACTIVITY 3
Find how many orders were made between the dates

Using SELECT COUNT(DISTINCT Order_id) Total_orders_made FROM order_details; we found the totl number of orders made between these dates to be 5370

ACTIVITY 4
Tell how many items were ordered in all

By using SELECT COUNT(DISTINCT item_id) Total_items_ordered FROM order_details; I found that the total number of items that were ordered is 32 and they were all ordered 12,234 times

ACTIVITY 5
Find the order that has the most number of items in it

Using SELECT order_id, COUNT(item_id) Order_num FROM order_details GROUP BY order_id ORDER BY order_num DESC; I pulled up the orders and the number of items in them discovering that a number of orders have 14 items in them each. Putting this query into a CTE I sorted how many of those orders have 14 items in each of them using 
With Order_num AS 
(
SELECT order_id, COUNT(item_id) Order_num
FROM order_details
GROUP BY order_id
ORDER BY order_num DESC
)
SELECT *
FROM Order_num 
WHERE Order_num = 14; they were 7 in all 


ACTIVITY 6 
Find how many orders have more than 12 items in them
To get this, I used WITH Order_num AS (SELECT order_id, COUNT(item_id) Order_num FROM order_details GROUP BY order_id HAVING Order_num > 12 ORDER BY order_num DESC) SELECT COUNT(*) FROM Order_num;
There were 
 Orders that have more than  12 items in them


STEP 3: ANALYZING CUSTOMERS’ BEHAVIOUR
ACTIVITY 1
Combine the menu_items and the order_details table

Using SELECT * FROM menu_items JOIN order_details ON menu_item_id = item_id; I joined both tables on a common column and made them ready to be queried

ACTIVITY 2
Find the least and most ordered items and the categories they belong to. 
By using WITH Joined_table AS (SELECT * FROM menu_items JOIN order_details ON menu_item_id = item_id) SELECT item_name, Category, COUNT(order_id) order_num FROM Joined_table GROUP BY item_name, category ORDER BY order_num DESC; I queried the data set and found that the most ordered item was hamburger in the American category whit had a total of 622 orders and the least ordered item was the mexican chicken tacos with just 123 orders

ACTIVITY 3: Find the top 5 orders that spent the most money

I found this by using WITH Joined_table AS (SELECT * FROM menu_items JOIN order_details ON menu_item_id = item_id) SELECT order_id, SUM(price) Total_money_spent FROM Joined_table GROUP BY order_id ORDER BY Total_money_spent DESC LIMIT 5;


INSIGHT
I went on to view the details of the highest spender and I noticed that he all spent a handsome amount of money on Italian dishes, I went ahead to check the details of the top 5 spenders and realized that they all spent handsomely on Italian foods.

RECOMMENDATION
After this insight, I hereby recommend that the restaurant make more Italian dishes than dishes in other categories given that the highest spenders spend a lot of money on Italian dishes and dub down a little on American dishes.



DATA USED 
<a href="https://github.com/TheAlphaAnalyst/Resturant-orders-analysis/blob/main/order_details.csv">Dataset</a>

<a hef="https://github.com/TheAlphaAnalyst/Resturant-orders-analysis/blob/main/menu_items.csv">Dataset</a>

