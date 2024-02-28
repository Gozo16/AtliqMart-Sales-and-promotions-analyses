select distinct(p1.product_name),p2.base_price,p2.product_code
from dim_products as p1
inner join fact_events as p2
on p1.product_code=p2.product_code
where p2.base_price>500 and p2.promo_type = "BOGOF"
order by p1.product_name asc;

select city, count( store_id) as Citycount 
from dim_stores
group by city 
order by Citycount desc;

select distinct(p1.campaign_name) as campaigns, 
sum(p2.`quantity_sold(before_promo)`*p2.base_price), sum(p2.`quantity_sold(after_promo)`*p2.base_price)
from fact_events as p2
inner join dim_campaigns as p1
ON p1.campaign_id = p2.campaign_id
group by campaigns
order by campaigns asc;

select (p1.category) as Cat,
((sum(`quantity_sold(after_promo)`)-sum(`quantity_sold(before_promo)`))/sum(`quantity_sold(before_promo)`)*100) as ISU_Percent,
Rank() Over (Order by (((Sum(p2.`quantity_sold(after_promo)`) - Sum(p2.`quantity_sold(before_promo)`)) / Sum(p2.`quantity_sold(before_promo)`)) * 100) desc) as Ranking
from dim_products as p1 
inner join fact_events as p2
on p1.product_code=p2.product_code
Where p2.campaign_id = "CAMP_DIW_01"
group by Cat;

select p1.product_name,p1.category,
(((sum(`quantity_sold(after_promo)` * base_price) - sum(`quantity_sold(before_promo)` * base_price)) / SUM(`quantity_sold(before_promo)` * base_price))*100) As IR_Percent
from dim_products as p1 
inner join fact_events as p2
on  p1.product_code=p2.product_code
group by p1.product_name,p1.category
order by IR_Percent Desc
limit 5;

