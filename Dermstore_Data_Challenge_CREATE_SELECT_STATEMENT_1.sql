USE dermstore;
/* 
This Select Statement shows the overall attribute_name, product sales revenue , cost, GP, as well as average selling price by qty by year
*/
SELECT attr_name.attribute_name, pr.product_id,pr.product_name, sum((pr.product_price)*o_i.item_quantity) as extPrice, sum((pr.product_cost)*o_i.item_quantity) as extCost, sum((pr.product_price-pr.product_cost)*o_i.item_quantity) as extGP, avg(o_i.item_price) as ASP,
concat('Q',QUARTER(o_i.date_created)) as Quarter_, Year(o_i.date_created) as Sale_Year
/* Joining Product and Order_item*/
FROM products pr left join orders_items o_i on pr.product_id=o_i.product_id 
left join 
/* Joining Attributes and products_attributes*/
(SELECT distinct prattr.product_id,attr.attribute_name
FROM attributes attr JOIN products_attributes prattr on attr.attribute_id=prattr.attribute_id) attr_name on pr.product_id=attr_name.attribute_name
/* Filtering out products that have no sales*/
where o_i.product_id is null
group by pr.product_id,pr.product_name,concat('Q',QUARTER(o_i.date_created)) ,Year(o_i.date_created),attr_name.attribute_name


