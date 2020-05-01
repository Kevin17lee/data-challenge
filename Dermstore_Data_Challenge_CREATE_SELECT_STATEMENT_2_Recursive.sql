
/*Create a product attribute path map that show case the attribute path for each product id/attribute name   (only works on MYSQL 5.8    */

WITH RECURSIVE attribute_path (attribute_id,attribute_name, path) as
(
   select attribute_id,attribute_name, attribute_name as path
   from attributes
   where attribute_parent_id is null /* it could be null or 0*/
   UNION ALL
   SELECT attr.attribute_id,attr.attribute_name, CONCAT(a_p.path, '>>',attr.attribute_name)
   FROM attribute_path as a_p join attributes as attr
		on a_p.attribute_id=attr.attribute_parent_id
)
SELECT * FROM attribute_path 
ORDER BY path;

/*

The following is Recursive run for the attribute name in SQL server, Thane mentioned it is ok to demonstrate this way


WITH  attribute_path as 
(
   select attribute_id,attribute_name, attribute_name as pathh
   from [DB].[dbo].[attributes]
   
   UNION ALL
   SELECT attr.attribute_id,attr.attribute_name, cast(a_p.pathh+cast('>>' as varchar(50))+attr.attribute_name as varchar(50))
   FROM attribute_path as a_p join [DB].[dbo].[attributes] as attr
		on a_p.attribute_id=attr.attribute_parent_id
)
SELECT * FROM attribute_path 
ORDER BY pathh



*/