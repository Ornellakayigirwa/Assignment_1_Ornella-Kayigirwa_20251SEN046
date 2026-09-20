--1. Ranking total spendings--
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



--2.Each customre's order--
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date,
       ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date, o.order_id) AS order_number
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, order_number;



--3.Total of the revenue overtime ordered by date--
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



--4. Each customer with more than one order, days between the current and previous order--
SELECT customer_id, order_id, order_date, prev_date,
       order_date - prev_date AS days_between
FROM (
  SELECT customer_id, order_id, order_date,
         LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_date
  FROM orders
)
WHERE prev_date IS NOT NULL
ORDER BY customer_id, order_date;

