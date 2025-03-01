-- this query shows the total number of customers
select COUNT(customer_id) as customers_count
from customers;

-- STEP 5 calc of top 10 sellers by income
select
	CONCAT(e.first_name, ' ', e.last_name) as seller,
	COUNT(s.sales_id) as operations,
	FLOOR(SUM(p.price * s.quantity)) as income
from sales s
join products p on s.product_id = p.product_id
join employees e on s.sales_person_id = e.employee_id
group by seller
order by income DESC
limit 10;

-- info about sellers and their avg income if it lower than avg of all sellers
WITH avgsalary AS (
    SELECT AVG(p.price * s.quantity) AS average_salary
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
)
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS seller,
    FLOOR(AVG(p.price * s.quantity)) AS average_income
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN employees e ON s.sales_person_id = e.employee_id
CROSS JOIN avgsalary avs
GROUP BY e.first_name, e.last_name, avs.average_salary
HAVING AVG(p.price * s.quantity) < avs.average_salary
ORDER BY average_income;

-- calc by day's of week income
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS seller,
    TO_CHAR(s.sale_date, 'day') as day_of_week,
    FLOOR(SUM(p.price * s.quantity)) AS income
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN employees e ON s.sales_person_id = e.employee_id
GROUP BY seller, day_of_week, extract(ISODOW from s.sale_date)
ORDER BY extract(ISODOW from s.sale_date), seller;



