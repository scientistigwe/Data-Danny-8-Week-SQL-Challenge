
/***		https://8weeksqlchallenge.com/case-study-1/		***/


CREATE DATABASE dannys_diner;

USE dannys_diner;
GO

CREATE TABLE sales (
	customer_id		varchar(1)	NOT NULL, 
	order_date		date		NOT NULL, 
	product_id		int
);

INSERT INTO sales 
	(customer_id, order_date, product_id)
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

CREATE TABLE members (
	customer_id		varchar(1), 
	join_date		date
);

INSERT INTO members (
	customer_id, join_date
)

VALUES 
	('A', '2021-01-07'),
	('B', '2021-01-09');

CREATE TABLE menu (
	product_id		int, 
	product_name	varchar(5), 
	price			int
);

INSERT INTO menu (
	product_id, product_name, price
)

VALUES 
	(1,	'sushi',	10),
	(2,	'curry',	15),
	(3,	'ramen',	12);

-- 1. What is the total amount each customer spent at the restaurant?
	SELECT customer_id [Customer ID],
	SUM(price) [Amount spent]
	FROM sales
	INNER JOIN menu ON sales.product_id = menu.product_id
	GROUP BY customer_id;

-- 2. How many days has each customer visited the restaurant?
	SELECT customer_id [Customer ID],
	COUNT (DISTINCT(order_date)) [Number of visits in Days]
	FROM sales
	GROUP BY sales.customer_id 
	ORDER BY [Number of visits in Days] DESC;


-- 3. What was the first item from the menu purchased by each customer?

	WITH cte_first_item (customer_id, first_product, order_date, ranking) AS (

		SELECT customer_id, product_name, order_date, DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date)
		FROM sales
		INNER JOIN menu ON sales.product_id = menu.product_id
		GROUP BY customer_id, product_name, order_date
)
	
	SELECT customer_id [Customer], first_product [First item purchased by customer], order_date, ranking
	FROM cte_first_item
	WHERE ranking = 1;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

WITH cte_item_purchased (Number, Item_purchased) AS (

	SELECT TOP 3 (count(sales.product_id)), product_name 
	FROM sales 
	INNER JOIN menu ON sales.product_id = menu.product_id
	GROUP BY product_name, sales.product_id

)

SELECT Number, Item_purchased 
FROM cte_item_purchased  
ORDER BY Number DESC;

select * from sales, menu, members;	
-- 5. Which item was the most popular for each customer?


-- 6. Which item was purchased first by the customer after they became a member?


-- 7. Which item was purchased just before the customer became a member?


-- 8. What is the total items and amount spent for each member before they became a member?


-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?



