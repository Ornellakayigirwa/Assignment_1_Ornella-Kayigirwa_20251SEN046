--1. Every order with the customer's name, city, and order date--
SELECT  o.order_id,c.customer_name, c.city, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date, o.order_id;

--2. Every order item with product name, category, price, and quantity --
SELECT oi.order_item_id, oi.order_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id, oi.order_item_id;

--3. All customers and their orders where they exist, including customers with no orders--
SELECT  c.customer_id,c.customer_name,c.city,o.order_id,o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;