
-- ----selecting products that belong to JEANS---
SELECT * FROM Product where catid in (
	SELECT catid FROM category where name="Jeans");
-- ----proving all product ids are unique ------ -- 
SELECT name FROM Product WHERE pid in (
	SELECT pid FROM Product GROUP BY pid HAVING COUNT(*)>=2);
-- ----to view past orders of a customer with name Sam --- 
SELECT * FROM Product WHERE pid in (
	SELECT pid FROM Cart WHERE cid = (SELECT cid FROM customer WHERE fname ='Sam' AND lname='Gorham')  AND status ='delivered');
-- -----to view products in cart of a customer with name Sam Gorham
SELECT p.name as productName ,p.rating,p.price,c.quantity,p.manufacturingDate FROM product p,cart c ,customer cu WHERE c.status='not delivered' AND c.cid=cu.cid AND cu.fname='Sam' AND p.pid =c.pid;

-- ------top 10 most expensive products----
SELECT * FROM Product ORDER BY price DESC LIMIT 10;
-- detail of customer who ordered a Jeans
SELECT * FROM Customer WHERE cid in 
	(SELECT cid FROM Cart WHERE status ='delivered' AND pid in 
		(SELECT pid FROM Product WHERE cid in 
			(SELECT catid FROM category where name='Jeans')));
-- ---find min and max product in store----
SELECT (SELECT name FROM Product WHERE price =(SELECT MIN(price) FROM PRODUCT)) AS min_cost_product,
	(SELECT MIN(price) FROM PRODUCT) AS min_cost, 
	(SELECT name FROM Product WHERE price = (SELECT MAX(price) FROM PRODUCT)) AS max_cost_product,
	(SELECT MAX(price) FROM PRODUCT) AS max_cost ;
-- ---------CATEGORY AND PRODUCTS-------            
SELECT Product.name AS ProductName,Category.name AS CategoryName FROM Product JOIN Category ON category.catid=product.catid ;
-- -----products sold between last three months---
SELECT * FROM Product WHERE pid in(
	SELECT pid FROM Cart WHERE payid in(
		SELECT payid FROM orderdetails WHERE orderdate>= DATE_SUB("2023-01-01", INTERVAL 3 MONTH)));
-- ----times differnet modes are used
SELECT modeofpayment,COUNT(*) AS noOfTimesUsed FROM Payment GROUP BY modeofpayment;
-- ----top 10 customers who have spent the most on purchases, along with their total spending
SELECT c.cid, c.fname, c.lname, SUM(p.price * ct.quantity) AS total_spending
FROM customer c
JOIN cart ct ON c.cid = ct.cid
JOIN product p ON ct.pid = p.pid
GROUP BY c.cid, c.fname, c.lname
ORDER BY total_spending DESC
LIMIT 10;
-- ----avg rating of products in category wise
SELECT cat.name, AVG(p.rating) as avg_rating FROM product p JOIN category cat ON p.catid = cat.catid GROUP BY cat.catid;
-- ---products and belonging category
SELECT Product.name AS ProductName,Category.name AS CategoryName FROM Product JOIN Category ON category.catid=product.catid ;

-- --number of times a delivery boy has delivered
SELECT deliveryboy.name, COUNT(delivery.payid) AS num_deliveries
FROM deliveryboy
JOIN delivery ON deliveryboy.did = delivery.did
GROUP BY deliveryboy.did
ORDER BY num_deliveries DESC;


-- top 5 customers who have spent the most on orders
SELECT c.fname,c.email, SUM(cart.price) AS total_spent
FROM customer c
JOIN cart ON c.cid = cart.cid
WHERE cart.status = 'delivered'
GROUP BY c.email
ORDER BY total_spent DESC
LIMIT 5;

-- ---details of all orders that have been delivered by delivery boy with id 1
SELECT c.fname, c.mname, c.lname, p.name as product_name, od.orderdate, db.name as delivery_boy_name
FROM customer c
JOIN cart ct ON c.cid = ct.cid
JOIN product p ON ct.pid = p.pid
JOIN payment pm ON ct.payid = pm.payid
JOIN orderdetails od ON pm.payid = od.payid
JOIN delivery d ON pm.payid = d.payid
JOIN deliveryboy db ON d.did = db.did
WHERE d.did = 1 AND ct.status = 'delivered';

-- ---customer details with no of orders and total amount spent
SELECT c.fname AS customer_fname, c.lname AS customer_lname, a.locality, a.city, a.state, 
COUNT(DISTINCT o.payid) AS num_orders, SUM(od.total_price) AS total_spent
FROM customer c 
JOIN address a ON c.cid = a.cid 
LEFT JOIN payment p ON a.aid = p.aid 
LEFT JOIN orderdetails o ON p.payid = o.payid 
LEFT JOIN (SELECT payid, SUM(quantity * price) AS total_price FROM cart GROUP BY payid) od ON p.payid = od.payid 
GROUP BY c.cid, a.aid 
ORDER BY total_spent DESC;
-- --customers and products that were ordered by COD as modeofpayment
SELECT c.fname AS customer_fname, c.lname AS customer_lname, p.name AS product_name ,p.price,p.quantity
FROM customer c
INNER JOIN cart ct ON c.cid = ct.cid
INNER JOIN product p ON ct.pid = p.pid
INNER JOIN payment pm ON ct.payid = pm.payid
WHERE pm.modeofpayment = 'COD';
-- --List the total number of orders and the total revenue generated by each retailer
SELECT r.fname, r.lname, COUNT(o.payid) AS total_orders, SUM(p.price) AS total_revenue
FROM Retailer r
JOIN product p ON r.rid = p.rid
JOIN cart ON p.pid = cart.pid
JOIN orderdetails o ON cart.payid = o.payid
GROUP BY r.rid
ORDER BY total_revenue DESC;


UPDATE Cart SET status = "delivered" WHERE pid = "10" AND cid="99";
UPDATE Product SET quantity = quantity + 5 WHERE catid in (SELECT catid FROM category WHERE name = "Pants");
DELETE FROM deliveryboy WHERE rating<=3 OR rating >5 ORDER BY rating ASC limit 20;
DELETE FROM Product WHERE rid = "10";
-- DELETE FROM Product WHERE price<0 ;
ALTER TABLE category CHANGE COLUMN name category_name VARCHAR(255) NOT NULL;
UPDATE Product p
INNER JOIN (
  SELECT pid, SUM(quantity) as delivered_quantity
  FROM cart
  WHERE status = 'delivered'
  GROUP BY pid
) c ON p.pid = c.pid
SET p.quantity = p.quantity - c.delivered_quantity;

-- delimiter $$ 

-- get mode of payments for different addresses and total count of each type of mode
SELECT modeofpayment,aid,count(*) 
FROM PAYMENT
GROUP BY MODEOFPAYMENT,AID WITH ROLLUP ;

-- get products with price<3000 and rating>3 grouped on the basis of category ID and manufacturing date
SELECT catid, manufacturingDate, count(pid)
FROM PRODUCT
where rating>3 and price<3000
GROUP BY catid, manufacturingDate WITH ROLLUP ;

-- get no of customers for each state and city
SELECT State, City, count(aid) as COUNT_OF_CUSTOMERS
FROM ADDRESS where cid between 10 and 2000
GROUP BY State, City WITH ROLLUP;

-- get number of products for each retailer and category
SELECT COALESCE(retailer.rid, 'ALL products') as Retailer_ID, catid AS Category_ID, count(*) as COUNT_OF_PRODUCTS
FROM PRODUCT,RETAILER where product.rid = retailer.rid
GROUP BY retailer.rid, catid WITH ROLLUP ;

-- Select @@version 

-- select * from customer ;
-- Non-conflicting transactions
START TRANSACTION;
INSERT INTO customer (fname,password,number,email) VALUES ('Sam','75fyu$&^G','9393931547','sam@example1.com');
INSERT INTO customer (fname,password,number,email) VALUES ('Eric','g#W&HGsjS','9912904954','eric@example1.com');
COMMIT;

START TRANSACTION;
UPDATE product SET price = price*1.1 WHERE pid = 34;
UPDATE product SET price = price*1.2 WHERE pid = 12;
COMMIT;

START TRANSACTION;
DELETE FROM customer WHERE fname = 'Sam' and number='9393931547' and email='sam@example1.com';
DELETE FROM customer WHERE fname = 'Eric' and number='9912904954' and email='eric@example1.com';
COMMIT;

START TRANSACTION;
UPDATE product SET price = price/1.1 WHERE pid = 34;
UPDATE product SET price = price/1.2 WHERE pid = 12;
COMMIT;

START TRANSACTION;
UPDATE product SET price = price*1.1 WHERE pid = 15;
INSERT INTO customer (fname,password,number,email) VALUES ('Sam','75fyu$&^G','9393931547','sam@example1.com');
rollback;