

-- Customers Table
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES (1, 'Davis Ganza', 'CHECK_EMAIL_1', 'Kigali');
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES (2, 'Bob Shimwa', 'CHECK_EMAIL_2', 'Kigali');
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES (3, 'Neila Lysee', 'neilaly@gmail.com', 'Bugesera');
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES (4, 'Prince Jabo', 'jaboprince2000@gmail.com', 'Kigali');
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES (5, 'Frank Habintwari', 'frankabintwari@gmail.com', 'CHECK_CITY_5');
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES (6, 'Ines Mutoni', 'mutoniines5@gmail.com', 'Kamonyi');

-- Products Table
INSERT INTO products (product_id, product_name, category, price)
VALUES (101, 'Orange Juice', 'Beverage', 1000);
INSERT INTO products (product_id, product_name, category, price)
VALUES (102, 'Coca-cola', 'Beverage', 1000);
INSERT INTO products (product_id, product_name, category, price)
VALUES (103, 'Bluetooth Headphones', 'Device', 30000);
INSERT INTO products (product_id, product_name, category, price)
VALUES (104, 'Acoustic guitar', 'Device', 225000);
INSERT INTO products (product_id, product_name, category, price)
VALUES (105, 'Nike air max', 'Shoes', 46000);
INSERT INTO products (product_id, product_name, category, price)
VALUES (106, 'Smart watch', 'Device', 32000);
INSERT INTO products (product_id, product_name, category, price)
VALUES (107, 'Digital Keyboard', 'Device', 42000);
INSERT INTO products (product_id, product_name, category, price)
VALUES (108, 'Milk', 'Dairy', 10000);

-- Orders Table
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (201, 1, TO_DATE('2026-01-05', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (202, 1, TO_DATE('2026-02-25', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (203, 3, TO_DATE('2026-02-28', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (204, 3, TO_DATE('2026-03-05', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (205, 3, TO_DATE('2026-04-15', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (206, 4, TO_DATE('2026-04-19', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (207, 4, TO_DATE('2026-04-22', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (208, 2, TO_DATE('2026-05-01', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (209, 2, TO_DATE('2026-05-05', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (210, 1, TO_DATE('2026-06-30', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (211, 2, TO_DATE('2026-06-10', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (212, 6, TO_DATE('2026-07-21', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (213, 6, TO_DATE('2026-07-31', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (214, 6, TO_DATE('2026-08-01', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (215, 6, TO_DATE('2026-08-25', 'YYYY-MM-DD'));

-- Order items Table
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (1, 201, 101, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (2, 201, 103, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (3, 202, 102, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (4, 202, 105, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (5, 203, 104, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (6, 203, 106, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (7, 204, 101, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (8, 204, 107, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (9, 205, 103, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (10, 205, 102, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (11, 206, 105, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (12, 206, 108, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (13, 207, 106, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (14, 207, 101, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (15, 208, 107, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (16, 208, 104, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (17, 209, 102, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (18, 210, 108, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (19, 211, 105, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (20, 212, 101, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (21, 213, 104, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (22, 214, 102, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (23, 214, 108, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (24, 215, 103, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (25, 215, 106, 1);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;