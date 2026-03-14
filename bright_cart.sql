use brightcart;
select * from orders limit 10;
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE orders
ADD order_date_new DATE;
UPDATE orders
SET order_date_new = STR_TO_DATE(order_date,'%d-%m-%Y');
ALTER TABLE orders
DROP COLUMN order_date;
ALTER TABLE orders
CHANGE order_date_new order_date DATE;
describe orders;


# Main part 

SELECT *,
IFNULL(ROUND((profit / net_revenue) * 100,2),0) AS profit_margin
FROM orders;
select round(sum(net_revenue),2) as total_revenue from orders;
select round(sum(profit),2) as total_profit from orders;
select primary_category,round(sum(net_revenue),2) as revenue_by_category from orders 
group by primary_category;
select primary_category,round(sum(product_cost),2) as cost_by_category from orders 
group by primary_category;
select primary_category,round(sum(profit),2) as profit_by_category from orders 
group by primary_category;
SELECT primary_category,
ROUND(SUM(profit) / SUM(net_revenue) * 100,2) AS profit_margin_by_category
FROM orders group by primary_category;

SELECT 
ROUND(SUM(profit) / SUM(net_revenue) * 100,2) AS total_profit_margin
FROM orders;
SELECT channel,
ROUND(SUM(net_revenue) / COUNT(order_id),2) AS average_order_value
FROM orders group by channel;
select channel, round(sum(profit),2) as total_profit from orders group by channel;
select channel , sum(net_revenue) from orders group by channel;
SELECT channel,
ROUND(SUM(profit) / SUM(net_revenue) * 100,2) AS total_profit_margin
FROM orders group by channel;
SELECT 
ROUND(SUM(returned) / COUNT(order_id) * 100,2) AS return_rate
FROM orders;
SELECT primary_category, channel, SUM(net_revenue) AS revenue_lost FROM orders
WHERE returned = 1
GROUP BY primary_category, channel;
SELECT primary_category,
ROUND(SUM(returned) / COUNT(order_id) * 100,2) AS return_rate
FROM orders group by primary_category ;

# loading products table
select * from products limit 10;
ALTER TABLE products
rename column ï»¿product_id to product_id;
describe products;

# loading marketing spend table
select * from marketing_spend limit 10;
ALTER TABLE marketing_spend
rename column ï»¿month to month;
describe marketing_spend;

SELECT 
platform,
SUM(spend) AS total_spend,
SUM(clicks) AS total_clicks,
SUM(conversions) AS total_conversions,
SUM(revenue_attributed) AS total_revenue,
ROUND(SUM(spend)/SUM(clicks),2) AS avg_cost_per_click,
ROUND(SUM(spend)/SUM(conversions),2) AS avg_cost_per_acquisition,
ROUND(SUM(revenue_attributed)/SUM(spend),2) AS return_on_ad_spent
FROM marketing_spend
GROUP BY platform;

SELECT 
month,
round(SUM(spend),2) AS total_marketing_spend,
round(SUM(revenue_attributed),2) AS total_revenue
FROM marketing_spend
GROUP BY month
ORDER BY month;




