/*
Create a joined table to show customer sales history by date and assigned ROW_NUMBER in ASC order
*/

SET @row_number=0;
SET @row_number1=0;
SET @customerid=123;
select custord1.customer_id,custord1.customer_firstname,custord1.customer_lastname,custord1.Orderdate as PriorSaleDate, custord1.SalesPerVisit as PriorSalesTotal,
 custord2.Orderdate as CurrentsaleDate, custord2.SalesPerVisit as CurrentSalesTotal, custord2.SalesPerVisit-custord1.SalesPerVisit as SalesVariance
FROM
(SELECT  (@row_number:=@row_number + 1) AS rnk,cust.customer_id,  cust.customer_firstname,cust.customer_lastname, ord.order_total as SalesPerVisit, date(ord.date_created) as Orderdate
/*
Joining Customer and order to aggregate sale history
*/
FROM orders as ord  left join customers as cust on ord.customer_id=cust.customer_id
ORDER BY cust.customer_id,ord.date_created) custord1 /* Compare Successive Rows within same table   */

 INNER JOIN  
 
 (SELECT  (@row_number:=@row_number + 1) AS rnk1,cust.customer_id, cust.customer_firstname,cust.customer_lastname, ord.order_total as SalesPerVisit, date(ord.date_created) as Orderdate
/*
Joining Customer and order to aggregate sale history
*/
FROM orders as ord  left join customers as cust on ord.customer_id=cust.customer_id
ORDER BY cust.customer_id,ord.date_created) custord2 on custord2.rnk1=custord1.rnk
where custord1.customer_id=@customerid

