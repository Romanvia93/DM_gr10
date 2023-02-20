select
	region.Region_name,
    cat.Category_name, 
	Year(ord.Order_Date) as year_order_date,
    sum(ord_prd.Quantity) as quantity,
    round(sum(ord_prd.Sales)/1e3,2) as sales_th,
    round(sum(ord_prd.Profit)/1e3,2) as profit_th
from dm_course_v25.Order as ord 
	join dm_course_v25.Order_Product as ord_prd on ord.Order_Id = ord_prd.Order_Id
    join dm_course_v25.customer_address as cust_address on ord.Customer_address_ID = cust_address.Customer_address_ID
    join dm_course_v25.postal as post on post.Postal_Code_ID = cust_address.Postal_Code_ID 
    join dm_course_v25.city as city on post.City_ID = city.City_ID
    join dm_course_v25.state as state on state.State_ID = city.State_ID
    join dm_course_v25.region as region on state.Region_ID = region.Region_ID
    join dm_course_v25.product as product on product.Product_ID= ord_prd.Product_ID
    join dm_course_v25.subcategory as subcat on product.SubCategory_ID= subcat.SubCategory_ID
    join dm_course_v25.Category as cat on cat.Category_ID = subcat.Caterogy_ID
group by  
	region.Region_name,
    cat.Category_name,
    Year(ord.Order_Date)  
    
    