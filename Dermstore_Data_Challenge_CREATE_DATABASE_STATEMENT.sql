USE DERMSTORE;
CREATE TABLE `customers` (
  `customer_id` int(10)  NOT NULL AUTO_INCREMENT,
  `store_id` int(10)  NOT NULL,
  `customer_firstname` varchar(50) NOT NULL,
  `customer_lastname` varchar(50) NOT NULL,
  `customer_email` varchar(50) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`)
) ;
CREATE TABLE `products` (
  `product_id` int(10)  NOT NULL AUTO_INCREMENT, 
  `product_name` varchar(50) NOT NULL,
  `product_price` numeric(18,2) DEFAULT NULL,
  `product_cost` numeric(18,2) DEFAULT NULL,
  `product_status` varchar(10) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
 ) ;
 CREATE TABLE `orders` (
  `order_id` int(10)  NOT NULL AUTO_INCREMENT, 
  `customer_id` int(10) NOT NULL,
  `order_total` int(10) DEFAULT NULL,
  `order_source` varchar(20) DEFAULT NULL,
   `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
   CONSTRAINT `fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)  ON UPDATE CASCADE
 ) ;
 CREATE TABLE `orders_items` (
  `order_id` int(10)  NOT NULL , 
  `product_id` int(10) NOT NULL,
  `item_quantity` int(10) DEFAULT NULL,
  `item_price` numeric(18,2) DEFAULT NULL,
   `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`order_id`,`product_id`),
   FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)  ON UPDATE CASCADE ,
	FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)  ON UPDATE CASCADE
) ;
CREATE TABLE `attributes` (
  `attribute_id` int(10)  NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(50) NOT NULL,
  `attribute_parent_id` int(10)  DEFAULT NULL,  
  PRIMARY KEY (`attribute_id`),
 CONSTRAINT `fk_attribute_parent_id` FOREIGN KEY (`attribute_parent_id`) REFERENCES `attributes` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
CREATE TABLE `products_attributes` (
`product_id` int(10) NOT NULL,
`attribute_id` int(10) NOT NULL,
PRIMARY KEY (`product_id`,`attribute_id`),
FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE ,
FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) 