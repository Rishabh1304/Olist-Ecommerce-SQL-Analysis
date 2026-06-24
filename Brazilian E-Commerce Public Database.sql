create database olist_ecommerce;
use olist_ecommerce;

-- PAYMENT METHOD PREFERENCE & REVENUE ANALYSIS
SELECT payment_type, COUNT(order_id) AS total_transactions, SUM(payment_value) AS total_revenue
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- TOP 10 BEST-SELLING PRODUCT CATEGORIES
SELECT p.product_category_name, 
       COUNT(i.order_id) AS total_sold
FROM olist_order_items_dataset i
JOIN olist_products_dataset p ON i.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sold DESC
LIMIT 10;

--  TOP 10 CITIES WITH THE HIGHEST CUSTOMER DENSITY
SELECT customer_city, customer_state, COUNT(customer_id) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_city,customer_state
ORDER BY total_customers DESC
LIMIT 10;

-- CUSTOMER SATISFACTION & REVIEW SCORE DISTRIBUTION
SELECT review_score, COUNT(review_id) AS total_reviews
FROM olist_order_reviews_dataset
GROUP BY review_score
ORDER BY review_score DESC;

-- MONTHLY ORDER TRENDS & SEASONALITY ANALYSIS
SELECT YEAR(STR_TO_DATE(SUBSTRING_INDEX(order_purchase_timestamp, ' ', 1), '%m/%d/%Y')) AS order_year, 
		MONTH(STR_TO_DATE(SUBSTRING_INDEX(order_purchase_timestamp, ' ', 1), '%m/%d/%Y')) AS order_month, 
        COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY order_year, order_month
ORDER BY order_year ASC, order_month ASC;

-- AVERAGE ORDER VALUE (AOV) ANALYSIS
SELECT AVG(payment_value) AS average_order_value
FROM olist_order_payments_dataset;

-- AVERAGE DELIVERY TIME (IN DAYS)
SELECT AVG(DATEDIFF(STR_TO_DATE(SUBSTRING_INDEX(order_delivered_customer_date, ' ', 1), '%m/%d/%Y'),
STR_TO_DATE(SUBSTRING_INDEX(order_purchase_timestamp, ' ', 1), '%m/%d/%Y'))) AS avg_delivery_days
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL;

-- TOP 5 SELLERS GENERATING HIGHEST REVENUE
SELECT seller_id, SUM(price) AS total_revenue_generated
FROM olist_order_items_dataset
GROUP BY seller_id
ORDER BY total_revenue_generated DESC
LIMIT 5;