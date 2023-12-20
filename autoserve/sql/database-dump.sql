-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: datawebsite
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Create database `autoserve`
--

DROP DATABASE IF EXISTS `autoserve`;
CREATE DATABASE `autoserve`;
USE `autoserve`;

--
-- Table structure for table `accessory`
--

DROP TABLE IF EXISTS `accessory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accessory` (
  `ACC_NO` int(11) NOT NULL,
  `NAME` char(20) NOT NULL,
  `BRAND` varchar(15) DEFAULT NULL,
  `DESCRIPTION` char(50) DEFAULT NULL,
  `COST` int(11) DEFAULT NULL,
  PRIMARY KEY (`ACC_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessory`
--

LOCK TABLES `accessory` WRITE;
/*!40000 ALTER TABLE `accessory` DISABLE KEYS */;
INSERT INTO `accessory` VALUES (100201,'Car Covers','Honda','Red, 15x6x5',150),(100202,'Wash clorth','Alverez','10pc pack Green & Gray 10x10',100),(100203,'Seats covers','Aztech','Four pieces',150),(100204,'Air fresheners','Febreze','Five unit packs',50),(100205,'Flat Repair kit','Repair it','56 Pieces comprehensive tire repair kit',200),(100206,'Tire inflator','Fortem','Powerful 120W, 19.4 x 15.6 x 7.5cm, 150PSI',200);
/*!40000 ALTER TABLE `accessory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clerk`
--

DROP TABLE IF EXISTS `clerk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clerk` (
  `CLERK_ID` int(11) NOT NULL,
  `FNAME` char(20) NOT NULL,
  `LNAME` char(20) NOT NULL,
  `ADDRESS` char(50) DEFAULT NULL,
  `EMAIL` char(30) DEFAULT NULL,
  `CONTACT_NO` int(12) DEFAULT NULL,
  `DATE_OF_BIRTH` date DEFAULT NULL,
  `USERNAME` char(20) NOT NULL,
  `PASSWORD` char(8) NOT NULL,
  PRIMARY KEY (`CLERK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clerk`
--

LOCK TABLES `clerk` WRITE;
/*!40000 ALTER TABLE `clerk` DISABLE KEYS */;
INSERT INTO `clerk` VALUES (1001,'Janet','James','#47th Alfred & James','j.james1@autoserve.com',6457331,'1998-10-10','J.James','Auto1J.J'),(1002,'Alfred','Hills','#66th & 3rd kelly Village','a.hills2@autoserve.com',7865432,'1997-12-06','A.Hills','Auto2A.H'),(1003,'Ali','Tout','#67th Kimber Drive','a.tout3@autoserve.com',3456876,'1995-11-12','A.Tout','Auto3A.T'),(1004,'Gordin','Luthor','#81st & 3rd Blake Hights','g.luthor4@autoserve.com',7899143,'1996-10-11','G.Luthor','Auto4G.L');
/*!40000 ALTER TABLE `clerk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CUSTOMER_ID` int(11) NOT NULL,
  `FNAME` char(20) NOT NULL,
  `LNAME` char(20) NOT NULL,
  `EMAIL` char(30) DEFAULT NULL,
  `CONTACT_NO` int(11) DEFAULT NULL,
  `USERNAME` char(20) NOT NULL,
  `PASSWORD` char(8) NOT NULL,
  PRIMARY KEY (`CUSTOMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1506,'Albert','James','ajames@gmail.com',6787231,'AJames','AJ123'),(1507,'Henry','Tom','htom@gmail.com',9891231,'HTom','HT123'),(1508,'Lex','Tome','ltome@gmail.com',2345761,'LTome','LT123'),(1509,'Wetoma','Elvis','welvis@hotmail.com',7687232,'WElvis','WE123'),(1510,'ken','Ziga','kziga@outlook.com',5674213,'KZiga','KZ123');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inovice_parts`
--

DROP TABLE IF EXISTS `inovice_parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inovice_parts` (
  `INVOICE_NO` int(11) NOT NULL,
  `PART_NO` int(11) NOT NULL,
  `QUANTITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`INVOICE_NO`,`PART_NO`),
  KEY `PART_NO` (`PART_NO`),
  CONSTRAINT `inovice_parts_ibfk_1` FOREIGN KEY (`INVOICE_NO`) REFERENCES `invoice` (`INVOICE_NO`),
  CONSTRAINT `inovice_parts_ibfk_2` FOREIGN KEY (`PART_NO`) REFERENCES `part` (`PART_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inovice_parts`
--

LOCK TABLES `inovice_parts` WRITE;
/*!40000 ALTER TABLE `inovice_parts` DISABLE KEYS */;
INSERT INTO `inovice_parts` VALUES (10101,1846,4),(10102,1851,1),(10103,1850,2);
/*!40000 ALTER TABLE `inovice_parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `INVOICE_NO` int(11) NOT NULL,
  `DATE` date DEFAULT NULL,
  `TOTAL_COST` int(11) DEFAULT NULL,
  `CLERK_ID` int(11) NOT NULL,
  `CUSTOMER_ID` int(11) NOT NULL,
  `SERVICE_ID` int(11) NOT NULL,
  PRIMARY KEY (`INVOICE_NO`),
  KEY `CLERK_ID` (`CLERK_ID`),
  KEY `CUSTOMER_ID` (`CUSTOMER_ID`),
  KEY `SERVICE_ID` (`SERVICE_ID`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`CLERK_ID`) REFERENCES `clerk` (`CLERK_ID`),
  CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `customer` (`CUSTOMER_ID`),
  CONSTRAINT `invoice_ibfk_3` FOREIGN KEY (`SERVICE_ID`) REFERENCES `service` (`SERVICE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (10101,'2019-06-14',1250,1001,1506,10023),(10102,'2019-06-11',350,1002,1507,10024),(10103,'2019-06-11',450,1003,1508,10025),(10104,'2019-06-11',450,1004,1509,10026),(10105,'2019-06-12',250,1001,1510,10027);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_accessories`
--

DROP TABLE IF EXISTS `invoice_accessories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_accessories` (
  `INVOICE_NO` int(11) NOT NULL,
  `ACC_NO` int(11) NOT NULL,
  `QUANTITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`INVOICE_NO`,`ACC_NO`),
  KEY `ACC_NO` (`ACC_NO`),
  CONSTRAINT `invoice_accessories_ibfk_1` FOREIGN KEY (`INVOICE_NO`) REFERENCES `invoice` (`INVOICE_NO`),
  CONSTRAINT `invoice_accessories_ibfk_2` FOREIGN KEY (`ACC_NO`) REFERENCES `accessory` (`ACC_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_accessories`
--

LOCK TABLES `invoice_accessories` WRITE;
/*!40000 ALTER TABLE `invoice_accessories` DISABLE KEYS */;
INSERT INTO `invoice_accessories` VALUES (10101,100201,1),(10102,100203,1),(10103,100202,1),(10104,100204,2),(10105,100202,1);
/*!40000 ALTER TABLE `invoice_accessories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mechanic`
--

DROP TABLE IF EXISTS `mechanic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mechanic` (
  `MECHANIC_ID` int(11) NOT NULL,
  `FNAME` char(20) NOT NULL,
  `LNAME` char(20) NOT NULL,
  `ADDRESS` char(30) DEFAULT NULL,
  `DATE_OF_BIRTH` date DEFAULT NULL,
  `CONTACT_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`MECHANIC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mechanic`
--

LOCK TABLES `mechanic` WRITE;
/*!40000 ALTER TABLE `mechanic` DISABLE KEYS */;
INSERT INTO `mechanic` VALUES (41,'Lex','Luth','#34th Hill Toppers','1981-12-09',5698123),(42,'Rex','Ant','#65th Zambia Trace','1982-11-12',5672134),(43,'Wem','Tate','#87th Zambia Trace','1980-10-11',4567234),(44,'Ken','Hugs','#54th Love Drive','1985-06-04',1237654),(45,'Lary','Ming','#43th Astern Hill','1991-09-08',1878786);
/*!40000 ALTER TABLE `mechanic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part`
--

DROP TABLE IF EXISTS `part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `part` (
  `PART_NO` int(11) NOT NULL,
  `NAME` char(50) NOT NULL,
  `DESCRIPTION` text,
  `COST` int(11) DEFAULT NULL,
  PRIMARY KEY (`PART_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part`
--

LOCK TABLES `part` WRITE;
/*!40000 ALTER TABLE `part` DISABLE KEYS */;
INSERT INTO `part` VALUES (1845,'Bilstein PSS9 Coilovers','Shock absorbtion System',1000),(1846,'Engine mount','The engine mount is the part of the chassis on which an engine is supported.',150),(1847,'Gear box','The component that turns the engine\'s power into something the car can use.',300),(1848,'Radiator','A radiator is a type of heat exchanger. It is designed to transfer heat from the hot coolant that flows through it to the air blown through it by the fan.',340),(1849,'Ford Performance Cold Air Intake and Throttle Body','Air intake system',949),(1850,'Brake pads','Brake pads provide the friction to slow or stop your vehicle.',50),(1851,'Oil filter','Filtration kit for engine oil.',100);
/*!40000 ALTER TABLE `part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `SERVICE_ID` int(11) NOT NULL,
  `DATE` date DEFAULT NULL,
  `CUSTOMER_ID` int(11) NOT NULL,
  `CLERK_ID` int(11) NOT NULL,
  `VEHICLE_NO` int(11) NOT NULL,
  PRIMARY KEY (`SERVICE_ID`),
  KEY `CUSTOMER_ID` (`CUSTOMER_ID`),
  KEY `CLERK_ID` (`CLERK_ID`),
  KEY `service_ibfk_2_idx` (`VEHICLE_NO`),
  CONSTRAINT `service_ibfk_1` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `customer` (`CUSTOMER_ID`),
  CONSTRAINT `service_ibfk_2` FOREIGN KEY (`CLERK_ID`) REFERENCES `clerk` (`CLERK_ID`),
  CONSTRAINT `service_ibfk_3` FOREIGN KEY (`VEHICLE_NO`) REFERENCES `vehicle` (`VEHICLE_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (10023,'2019-06-10',1506,1001,101),(10024,'2019-06-11',1507,1002,102),(10025,'2019-06-11',1508,1003,103),(10026,'2019-06-11',1509,1004,104),(10027,'2019-06-12',1510,1001,105);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_tasks`
--

DROP TABLE IF EXISTS `service_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_tasks` (
  `SERVICE_ID` int(11) NOT NULL,
  `TASK_NO` int(11) NOT NULL,
  `START_DATE` date DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `STATUS` char(25) NOT NULL,
  `MECHANIC_ID` int(11) NOT NULL,
  PRIMARY KEY (`SERVICE_ID`,`TASK_NO`),
  KEY `service_tasks_ibfk_1` (`TASK_NO`),
  KEY `service_tasks_ibfk_3` (`MECHANIC_ID`),
  CONSTRAINT `service_tasks_ibfk_1` FOREIGN KEY (`TASK_NO`) REFERENCES `task` (`task_no`),
  CONSTRAINT `service_tasks_ibfk_2` FOREIGN KEY (`SERVICE_ID`) REFERENCES `service` (`SERVICE_ID`),
  CONSTRAINT `service_tasks_ibfk_3` FOREIGN KEY (`MECHANIC_ID`) REFERENCES `mechanic` (`MECHANIC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_tasks`
--

LOCK TABLES `service_tasks` WRITE;
/*!40000 ALTER TABLE `service_tasks` DISABLE KEYS */;
INSERT INTO `service_tasks` VALUES (10023,1301,'2019-06-10','2019-06-14','Completed',45),(10024,1303,'2019-06-11','2019-06-11','Completed',44),(10025,1304,'2019-06-11','2019-06-11','Completed',41),(10026,1305,'2019-06-11','2019-06-11','Completed',42),(10027,1306,'2019-06-12','2019-06-12','Completed',43);
/*!40000 ALTER TABLE `service_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `TASK_NO` int(11) NOT NULL,
  `NAME` char(100) NOT NULL,
  `DESCRIPTION` text,
  `COST` int(11) DEFAULT NULL,
  PRIMARY KEY (`TASK_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1301,'Maintenance & Repair','Maintenance & Repairdone for any issue.',500),(1302,'Factory recommended maintenance','Factory-recommended maintenance services for most vehicles which are done at different mileage intervals to ensure proper operation and prevent premature wear.',400),(1303,'Oil & Filter Change','Oil changes and / or top-up the oil (for Engine, Steering, Transmission, and Coolant)',150),(1304,'Brake Services','Brake system checks are conducted and we replace Brake Pads, Brake Shoes, Discs & top-up Brake fluids if required.',250),(1305,'Air Conditioning Services','Diagnoses and repairof most HVAC related problems.',350),(1306,'Tyre Services','We replace worn & damaged tyres with new ones, perform tyre rotation, check air pressure and adjust inflation and fix other minor problems. We fix punctures and damaged valves for Tubeless Tyres.',150);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `VEHICLE_NO` int(11) NOT NULL,
  `CUSTOMER_ID` int(11) NOT NULL,
  `LICENSE_NO` int(8) NOT NULL,
  `MAKE` char(20) DEFAULT NULL,
  `MODEL` char(20) DEFAULT NULL,
  `YEAR` int(4) DEFAULT NULL,
  `MILEAGE` int(7) DEFAULT NULL,
  PRIMARY KEY (`VEHICLE_NO`),
  KEY `vehicle_idfk_1_idx` (`CUSTOMER_ID`),
  CONSTRAINT `vehicle_idfk_1` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `customer` (`CUSTOMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (101,1506,21567236,'Nissan','L2100',2018,28000),(102,1507,32456579,'Mazda','Z3',2017,30000),(103,1508,56897678,'BMW','S-class',2018,27000),(104,1509,45657453,'Land Rover','Z-Tech',2019,19000),(105,1510,67589432,'Audi','F810000',2019,15000);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-01 22:12:44
