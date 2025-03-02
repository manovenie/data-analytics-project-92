INSERT INTO "select 
	case
		when c.age between 16 and 25 then '16-25'
		when c.age between 26 and 40 then '26-40'
		when c.age > 40 then '40+'
	end as age_category,
	COUNT(c.customer_id) as age_count
from customers c
group by age_category
order by 1" (age_category,age_count) VALUES
	 ('16-25',2663),
	 ('26-40',5139),
	 ('40+',11957);
