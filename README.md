# **Assignment 1 – Sunrise Supermarket Sales Analysis**

**Name:** Kayigirwa Ornella  
**ID:** 20251SEN046  
**Database Used:** Oracle Database (SQL Developer)  
**Repository:** Assignment_1_Ornella-Kayigirwa-20251SEN046

 ## *Overview*
The project involves an analysis of the sales data for Sunrise Supermarket.
Four related tables (customers, products, orders, order_items) were set up and filled with realistic sample data,
and a number of SQL queries employing INNER JOIN, LEFT JOIN, CTEs and window functions were prepared in order that management might gain an understanding of customers,
products and sales trends over time.


**Scenario**
Sunrise Supermarket sells products to customers. Customers place orders that contain one or more items.  

Management wants to understand:
+ Who their customers are and where they live
+ What products are being bought and in which categories
+ Which customers spend the most

## 1. DataBase Scheme
```sql
CREATE TABLE customers (
  customer_id   NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100),
  email         VARCHAR2(100),
  city          VARCHAR2(50)
);

CREATE TABLE products (
  product_id   NUMBER PRIMARY KEY,
  product_name VARCHAR2(100),
  category     VARCHAR2(50),
  price        NUMBER(10,2)
);

CREATE TABLE orders (
  order_id    NUMBER PRIMARY KEY,
  customer_id NUMBER REFERENCES customers(customer_id),
  order_date  DATE
);

CREATE TABLE order_items (
  order_item_id NUMBER PRIMARY KEY,
  order_id      NUMBER REFERENCES orders(order_id),
  product_id    NUMBER REFERENCES products(product_id),
  quantity      NUMBER
);
```
For each table:
+ At least 5 customers for the customres table
+ At least 8 products across 3 categories in the products table
+ At least 15 orders and Multiple different order dates inside the orders table
+ At least 25 order items in the order_items table

 ## 2. JOIN QUERIES
  
  ### JOIN 1: Every order with customer name, city, and order date (INNER JOIN)
  ```sql
  SELECT  o.order_id,c.customer_name, c.city, o.order_date
  FROM orders o
  INNER JOIN customers c ON o.customer_id = c.customer_id
  ORDER BY o.order_date, o.order_id;
  ```
Since the orders table contains only a column named ***customer_id***, the INNER JOIN joins it with the ***customers.customer_id*** and prints out the names and cities of customers.
The reason for this is that the INNER JOIN includes only those rows which have matches on both sides.

  ***Result: 15 rows, one per order***<img width="1359" height="690" alt="JOIN-1" src="https://github.com/user-attachments/assets/5a5db6a7-1860-43f7-a33b-a3b20c7792b6" />

In reference to the business scenario, Management will be able to see who is buying and from where.
Kigali is responsible for 8 out of the 15 orders and hence the biggest market,
while Kamonyi and Bugesera have 4 and 3 orders respectively. The most prolific buyer is Ines Mutoni from Kamonyi, who has placed 4 orders.
Frank Habintwari is not there on the list since he never made an order, as per Query 3.

#
### JOIN 2: Every order item with product name, category, price, and quantity
```sql
SELECT oi.order_item_id, oi.order_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id, oi.order_item_id;
```
The table order_items has only the field product_id. The JOIN connects order_items.product_id with products.product_id in order to show us what was ordered,
its category and price. There is no NULL value in the foreign key field, so 25 rows are selected.

***Result: 25 rows***<img width="1366" height="688" alt="JOIN-2 1" src="https://github.com/user-attachments/assets/f62d3203-da92-4046-a3fc-7b3b74c10321" />,<img width="1366" height="689" alt="JOIN-2 2" src="https://github.com/user-attachments/assets/9185a5e4-143a-4d79-8eb7-38e6e40cf379" />

The Products represent the largest number of order lines (11 out of 25). Beverages follow second with eight orders. 
Thus, those two product groups are responsible for sales. Beverages are cheap but have many orders. On the other hand, Devices and Shoes generate less orders but more expensive ones.
The Acoustic guitar has the highest price among products (225,000). Thus, a couple of its sales may greatly affect revenues.

#
### JOIN 3: All customers and their orders, including customers with no orders (LEFT JOIN)
```sql
SELECT  c.customer_id,c.customer_name,c.city,o.order_id,o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;
```
In a LEFT JOIN, all the rows from customers will be retained, while those that match with any rows from orders will be joined. 
Those customers who have no orders will still be included, with NULL values in the order columns.

Result: 16 rows: 15 orders including one row for a customer with no order<img width="1362" height="692" alt="JOIN-3" src="https://github.com/user-attachments/assets/db2c24c8-942f-48ae-b243-275503771b79" />

All 6 registered customers attended, not just the 5 that have made purchases. Frank Habintwari has never made an order; hence, he is a good candidate to receive a promotional discount offer.
An INNER JOIN would not have included him in the results.

## 3. CTE Query
### Customers with above-average total spend
```sql
WITH customer_total AS (
  SELECT c.customer_id, c.customer_name, SUM(oi.quantity * p.price) AS total_spend
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
  )
  SELECT customer_id, customer_name, total_spend
  FROM customer_total
  WHERE total_spend > (SELECT AVG(total_spend) FROM customer_total)
  ORDER BY total_spend DESC;
```
The CTE customer_totals includes customers, orders, order_items, and products and calculates the sum of quantity * price for each customer.
The outer query returns only those customers whose total amount is greater than the average of these totals where the average considers 
only those customerswho made an order.

***Result: 3 customers above the average of 269,000***<img width="1366" height="692" alt="CTE" src="https://github.com/user-attachments/assets/cc9415dd-9189-4f04-a38b-a1435ddf77b7" />

Neila Lysee, Bob Shimwa, and Ines Mutoni are the most valuable customers due to the large number of Acoustic guitar (225,000) purchases they make.
The management should consider giving them loyalty discounts while Davis and Prince may be considered for promotions.


## 4. Window Function Queries

### Window 1: Rank customers by total spend
```sql
WITH customer_total AS (
  SELECT c.customer_id, c.customer_name, SUM(oi.quantity * p.price) AS total_spend
  FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, total_spend, 
  RANK() OVER(ORDER BY total_spend DESC) AS spending_rank
FROM customer_total
ORDER BY spending_rank;
```
First, the customer_total CTE calculates the total cost per customer (quantity * price). 
Next, RANK() OVER (ORDER BY total_spend DESC) assigns rank number 1 to the highest spender.As opposed to GROUP BY, 
the window function does not exclude any rows, but just adds a ranking column. Non-ordering customers are excluded from this list.

***Result: 5 ranked customers***<img width="1366" height="691" alt="CTE-windows" src="https://github.com/user-attachments/assets/d8b0fe91-1c87-4646-af0c-3587ccb81b90" />

Neila Lysee leads in spending at 403,000, while Bob Shimwa is second with 361,000 and third is Ines Mutoni with 301,000. 
Together these three account imply that only a handful of customers generate most revenues. 
Davis Ganza and Prince Jabo rank bottom.

#
### Window 2: Number each customer's orders in the order placed
```sql
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date,
       ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date, o.order_id) AS order_number
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, order_number;
```
ROW_NUMBER() assigns row number 1, 2, 3... to each customer’s order based on order_date and starts counting
from 1 for each customer again using PARTITION BY clause.

***Result: 15 rows, each order numbered within its customer*** <img width="1364" height="693" alt="windows-2" src="https://github.com/user-attachments/assets/89b62845-86e7-4716-b21f-5f328db260de" />

This is an indication of how purchase histories develop: Ines Mutoni has the most purchase history, which includes 4 orders,
whereas Prince Jabo only has 2 orders. The order number can be used by management to distinguish first time purchasers from those making follow-up orders.

#
### Window 3: Running total of revenue over time
```SQL
WITH order_revenue AS (
  SELECT o.order_id, o.order_date, SUM(oi.quantity * p.price) AS revenue
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  GROUP BY o.order_id, o.order_date
)
SELECT order_id, order_date, revenue,
       SUM(revenue) OVER (ORDER BY order_date) AS running_total
FROM order_revenue
ORDER BY order_date;
```
Order_revenue CTE computes the revenue for each order, which is the product of quantity and price. 
And then SUM(revenue) OVER (ORDER BY order_date) sums up all revenues in the sequence of order_date starting from the first date, so each row shows the total earned so far.

***Result: 15 rows, ending at a running total of 1,345,000***<img width="1357" height="691" alt="windows 3" src="https://github.com/user-attachments/assets/2937ca84-9b61-4358-9594-cc152a80801f" />

The total sales increased from 32,000 in January to 1,345,000 by August. The majority of the increase is from a couple of orders, 
namely order 203 (257,000), order 208 (267,000), and order 213 (225,000), all of which consist of the Acoustic Guitar. 
Small orders such as order 209 (2,000) and order 212 (3,000) contributed

#
### Window 4: Days between a customer's orders
```sql
SELECT customer_id, order_id, order_date, prev_date,
       order_date - prev_date AS days_between
FROM (
  SELECT customer_id, order_id, order_date,
         LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_date
  FROM orders
)
WHERE prev_date IS NOT NULL
ORDER BY customer_id, order_date;
```
LAG(order_date) gives the date of the previous order by the customer; this is achieved using PARTITION BY customer_id to treat each customer separately. 
By subtracting the dates, we get the number of days since the previous order was placed. Since First orders have no previous order, so they are filtered out,
which leaves only customers with repeat orders.

***Result: 10 rows***<img width="1366" height="692" alt="WINDOWS-4" src="https://github.com/user-attachments/assets/8bc2d848-a4d9-4474-a49f-121f7d01f3d7" />

Mutoni Ines is the most frequent buyer with intervals of 10, 1 and 24 days, hence she is a loyal customer. The longest time interval between orders is observed
in Davis Ganza (51 and 125 days); hence, he may have drifted away and needs to be reminded of his orders or enticed back. 
The management can use this information to detect the slowing down buyers.
#

## 5. Challenges Faced & Resolution

| Challenge | How I Solved It |
|-----------|-----------------|
| Understanding CTEs | At first I did not understand how CTEs work. I searched for tutorials and looked at many examples until I understood that a CTE is like a temporary result that you can use later in the same query. |
| Choosing the correct window function | I did not always know which window function to use. I had to research and test different ones. Through this process I learned new functions such as `RANK()`, `ROW_NUMBER()`, `SUM() OVER`, and especially `LAG()`. |
| Writing the correct syntax for window functions | Many examples online were hard to understand at the beginning. I practised step by step and tested each query until the results made sense. |
| Calculating days between orders | I learned that in Oracle you can simply subtract two dates (`order_date - previous_date`) to get the number of days. |
| Organising the work | I separated the project into different scripts: one for creating tables, one for inserting data, and one for all the analytical queries. |





