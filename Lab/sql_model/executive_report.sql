select 
	Year(ord.Order_Date) as year_order_date,
    sum(ord_prd.Quantity) as quantity,
    round(sum(ord_prd.Sales)/1e3,2) as sales_th,
    round(sum(ord_prd.Discount * ord_prd.Sales)/1e3,2) as discount_value_th,
    round(sum(ord_prd.Profit)/1e3,2) as profit_th
from dm_course_v25.Order as ord 
	join dm_course_v25.Order_Product as ord_prd
	on ord.Order_Id = ord_prd.Order_Id
group by  Year(ord.Order_Date)   




