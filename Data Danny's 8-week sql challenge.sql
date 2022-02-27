create database dannys_diner;

USE dannys_diner;
drop database dannys_diner;

create table sales (customer_id varchar(1) not null, order_date date, product_id int);
INSERT INTO sales (customer_id, order_date, product_id)
VALUES 
('A',	'2021-01-01',	1),
('A',	'2021-01-01',	2),
('A',	'2021-01-07',	2),
('A',	'2021-01-10',	3),
('A',	'2021-01-11',	3),
('A',	'2021-01-11',	3),
('B',	'2021-01-01',	2),
('B',	'2021-01-02',	2),
('B',	'2021-01-04',	1),
('B',	'2021-01-11',	1),
('B',	'2021-01-16',	3),
('B',	'2021-02-01',	3),
('C',	'2021-01-01',	3),
('C',	'2021-01-01',	3),
('C',	'2021-01-07',	3);

create table members (customer_id varchar(1), join_date date);
INSERT INTO members (customer_id, join_date)
VALUES 
('A', '2021-01-07'),
('B', '2021-01-09');

create table menu (product_id int, product_name varchar(5), price int);
INSERT INTO menu (product_id, product_name, price)
VALUES 
(1,	'sushi',	10),
(2,	'curry',	15),
(3,	'ramen',	12);

select * from sales, menu, members;
-- 1. What is the total amount each customer spent at the restaurant?
SELECT sales.customer_id, SUM(menu.price) AS 'Amount spent' FROM sales, menu GROUP BY customer_id;

-- 2. How many days has each customer visited the restaurant?
select sales.customer_id, SUM(DATEDIFF(DAY, order_date, join_date)) AS 'Days spent' FROM sales, members WHERE order_date IS NOT NULL GROUP BY sales.customer_id ORDER BY [Days spent] DESC;

-- 3. What was the first item from the menu purchased by each customer?


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?


-- 5. Which item was the most popular for each customer?


-- 6. Which item was purchased first by the customer after they became a member?


-- 7. Which item was purchased just before the customer became a member?


-- 8. What is the total items and amount spent for each member before they became a member?


-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?



