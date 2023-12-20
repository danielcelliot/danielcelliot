--
-- Create database `supremecutz`
--
DROP DATABASE IF EXISTS `supremecutz_demo`;
CREATE DATABASE `supremecutz_demo`;
USE `supremecutz_demo`;

--
-- Table structure for table `customer`
--
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `CUSTOMER_ID` int NOT NULL AUTO_INCREMENT,
  `FNAME` char(30) NOT NULL,
  `LNAME` char(30) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `CONTACT_NO` varchar(7) DEFAULT NULL,
  `REG_DATE` date NOT NULL,
  
  PRIMARY KEY (`CUSTOMER_ID`)
);

ALTER TABLE `customer` AUTO_INCREMENT=1506;


--
-- Data for table `customer`
--
INSERT INTO `customer` VALUES
    (null,'Ken','Ziga','test@outlook.com','test','5674213', '2015-01-03');


--
-- Table structure for table `feedback_form`
--
DROP TABLE IF EXISTS `feedback_form`;
CREATE TABLE `message_form` (
  `FEEDBACK_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` char(255) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `CONTACT_NO` int NOT NULL,
  `MESSAGE` text NOT NULL,
  
  PRIMARY KEY (`FEEDBACK_ID`)
);


--
-- Table structure for table `product`
--
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `PRODUCT_ID` int NOT NULL AUTO_INCREMENT,
  `BRAND` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `WEIGHT` float(5) NOT NULL,
  `UNIT_PRICE` decimal(10,2) NOT NULL,
  `IMAGE_MED` mediumblob DEFAULT NULL,
  `IMAGE_SMALL` mediumblob DEFAULT NULL,
  `STOCK_AMT` int NOT NULL,
  
  PRIMARY KEY (`PRODUCT_ID`)
);

--
-- Data for table `product`
--
 INSERT INTO `product` VALUES
	(null,'Beard Kit','Grooming & Care','Clean & Condition, Moisturizer & Styling',0.8,299.99,null,null,15),
	(null,'FAMILIFE','Manicure Set with Box','Multipurpose Grooming kit, Portable Travel Leather case',0.7,349.99,null,null,0),
	(null,'Surker','Hair Clippers','Precision Blades, Powerful & Durable motor',1.4,499.98,null,null,8),
    (null,'Cantu Men','Hair Care','3-in-1 collection, Shampoo/Conditioner/Wash',2.6,149.99,null,null,5),
	(null,'Rocky Mountain','Tea Tree Oil','Real essential oil, For all hair types',0.6,99.99,null,null,10),
	(null,'Heeta','Hair Scalp Massager','Ergonomic design, Manually operated (no batteries required)',0.15,29.99,null,null,6);


--
-- Table structure for table `orders`
--
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `ORDER_ID` int NOT NULL AUTO_INCREMENT,
  `CUSTOMER_ID` int NOT NULL,
  `DATE` date NOT NULL,
  `ADDRESS` varchar(255) NOT NULL,
  `CITY` varchar(255) NOT NULL,
  `CONTACT_NO` varchar(7) NOT NULL,
  `DELIVERY_INFO` text DEFAULT NULL,
  `CARD_NO` varchar(16) NOT NULL,
  `TOTAL` decimal(10,2) NOT NULL,
  `STATUS` varchar(50) NOT NULL,
  
  PRIMARY KEY (`ORDER_ID`),
  CONSTRAINT FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `customer` (`CUSTOMER_ID`)
);


--
-- Data for table `order`
--
INSERT INTO `orders` VALUES
	(null, 1506, '2015-02-20', '1A Example Street', 'St. James', '5551234', null, '1234567891234567', 2307.93, 'Complete'),
	(null, 1506, '2018-05-20', '1A Example Street', 'St. James', '5551234', null, '1234567891234567', 663.98, 'Cancelled');


--
-- Table structure for table `order_products`
--
DROP TABLE IF EXISTS `order_products`;
CREATE TABLE `order_products` (
  `ORDER_PRODUCTS_ID` int NOT NULL AUTO_INCREMENT,
  `ORDER_ID` int NOT NULL,
  `PRODUCT_ID` int NOT NULL,
  `QTY` int NOT NULL,
  
  PRIMARY KEY (`ORDER_PRODUCTS_ID`),
  CONSTRAINT FOREIGN KEY (`ORDER_ID`) REFERENCES `orders` (`ORDER_ID`),
  CONSTRAINT FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PRODUCT_ID`)
);


--
-- Data for table `order_products`
--
INSERT INTO `order_products` VALUES
	(null,1,1,3),
    (null,1,2,2),
    (null,1,3,1),
    (null,2,1,2);
