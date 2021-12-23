-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: bookticketsdb
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `app_feedback`
--

DROP TABLE IF EXISTS `app_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `trip_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_feedback_user_id_trip_id_d24990c2_uniq` (`user_id`,`trip_id`),
  KEY `app_feedback_trip_id_54e35c88_fk_app_trip_id` (`trip_id`),
  CONSTRAINT `app_feedback_trip_id_54e35c88_fk_app_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `app_trip` (`id`),
  CONSTRAINT `app_feedback_user_id_57be9fb8_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_feedback`
--

LOCK TABLES `app_feedback` WRITE;
/*!40000 ALTER TABLE `app_feedback` DISABLE KEYS */;
INSERT INTO `app_feedback` VALUES (7,'ok',2,13),(14,'test update feedback 2',5,13);
/*!40000 ALTER TABLE `app_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_line`
--

DROP TABLE IF EXISTS `app_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_line` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `end_point_id` bigint DEFAULT NULL,
  `start_point_id` bigint DEFAULT NULL,
  `price` decimal(8,0) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_line_start_point_id_end_point_id_5fa4bb07_uniq` (`start_point_id`,`end_point_id`),
  KEY `app_line_end_point_id_1fa1352d_fk_app_point_id` (`end_point_id`),
  CONSTRAINT `app_line_end_point_id_1fa1352d_fk_app_point_id` FOREIGN KEY (`end_point_id`) REFERENCES `app_point` (`id`),
  CONSTRAINT `app_line_start_point_id_0801ba8f_fk_app_point_id` FOREIGN KEY (`start_point_id`) REFERENCES `app_point` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_line`
--

LOCK TABLES `app_line` WRITE;
/*!40000 ALTER TABLE `app_line` DISABLE KEYS */;
INSERT INTO `app_line` VALUES (2,'TPHCM - Đà Lạt',4,1,320000,1),(3,'Đà Lạt - TPHCM',1,4,320000,1),(4,'TPHCM - Tây Ninh',3,1,500000,1),(5,'Tây Ninh - TPHCM',1,3,100000,1),(6,'Tây Ninh - Đà Lạt',4,3,100000,1);
/*!40000 ALTER TABLE `app_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_point`
--

DROP TABLE IF EXISTS `app_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_point` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_point`
--

LOCK TABLES `app_point` WRITE;
/*!40000 ALTER TABLE `app_point` DISABLE KEYS */;
INSERT INTO `app_point` VALUES (1,'TPHCM',1),(2,'Vĩnh Long',1),(3,'Tây Ninh',1),(4,'Đà Lạt',1),(5,'TP Vũng Tàu',1),(6,'Vĩnh Phúc',1),(7,'Hà Nội',1);
/*!40000 ALTER TABLE `app_point` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_ticket`
--

DROP TABLE IF EXISTS `app_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_ticket` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint DEFAULT NULL,
  `employee_id` bigint DEFAULT NULL,
  `trip_id` bigint DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_ticket_trip_id_e58b726b_fk_app_trip_id` (`trip_id`),
  KEY `app_ticket_customer_id_9f11fd4b_fk_app_user_id` (`customer_id`),
  KEY `app_ticket_employee_id_bb25f7f5_fk_app_user_id` (`employee_id`),
  CONSTRAINT `app_ticket_customer_id_9f11fd4b_fk_app_user_id` FOREIGN KEY (`customer_id`) REFERENCES `app_user` (`id`),
  CONSTRAINT `app_ticket_employee_id_bb25f7f5_fk_app_user_id` FOREIGN KEY (`employee_id`) REFERENCES `app_user` (`id`),
  CONSTRAINT `app_ticket_trip_id_e58b726b_fk_app_trip_id` FOREIGN KEY (`trip_id`) REFERENCES `app_trip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_ticket`
--

LOCK TABLES `app_ticket` WRITE;
/*!40000 ALTER TABLE `app_ticket` DISABLE KEYS */;
INSERT INTO `app_ticket` VALUES (12,13,NULL,2,'2021-08-10 14:19:10.268281'),(13,14,15,2,'2021-08-10 14:19:11.619372'),(14,13,NULL,2,'2021-08-10 14:19:12.546587'),(15,13,NULL,2,'2021-08-10 14:19:13.523627'),(16,13,NULL,2,'2021-08-10 14:19:14.629597'),(17,13,NULL,5,'2021-08-22 17:04:35.241891'),(18,15,NULL,6,'2021-08-22 18:05:15.974442'),(19,15,NULL,6,'2021-08-22 18:05:53.768178'),(20,15,NULL,6,'2021-08-22 18:06:57.748021'),(21,15,NULL,6,'2021-08-22 18:07:41.566957'),(22,15,NULL,6,'2021-08-22 18:24:36.299822'),(23,15,NULL,5,'2021-08-22 18:29:47.267486'),(24,15,NULL,7,'2021-08-23 12:27:47.396744');
/*!40000 ALTER TABLE `app_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_ticketdetail`
--

DROP TABLE IF EXISTS `app_ticketdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_ticketdetail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seat_position` varchar(2) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `ticket_id` bigint NOT NULL,
  `vehicle_id` bigint DEFAULT NULL,
  `current_price` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_ticketdetail_vehicle_id_dd2f3eaf_fk_app_vehicle_id` (`vehicle_id`),
  KEY `app_ticketdetail_ticket_id_86f379dc_fk_app_ticket_id` (`ticket_id`),
  CONSTRAINT `app_ticketdetail_ticket_id_86f379dc_fk_app_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `app_ticket` (`id`),
  CONSTRAINT `app_ticketdetail_vehicle_id_dd2f3eaf_fk_app_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `app_vehicle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_ticketdetail`
--

LOCK TABLES `app_ticketdetail` WRITE;
/*!40000 ALTER TABLE `app_ticketdetail` DISABLE KEYS */;
INSERT INTO `app_ticketdetail` VALUES (9,'1','Vui lòng đến trước giờ bắt đầu 15\' !!',12,1,106000),(10,'2','Vui lòng đến trước giờ bắt đầu 15\' !!',13,1,106000),(11,'3','Vui lòng đến trước giờ bắt đầu 15\' !!',14,1,106000),(12,'4','Vui lòng đến trước giờ bắt đầu 15\' !!',15,1,106000),(13,'5','Vui lòng đến trước giờ bắt đầu 15\' !!',16,1,106000),(14,'1','Vui lòng đến trước giờ bắt đầu 15\' !!',17,1,320000),(15,'1','Vui lòng đến trước giờ bắt đầu 15\' !!',18,1,320000),(16,'2','Vui lòng đến trước giờ bắt đầu 15\' !!',19,1,320000),(17,'3','Vui lòng đến trước giờ bắt đầu 15\' !!',20,1,320000),(18,'4','Vui lòng đến trước giờ bắt đầu 15\' !!',21,1,320000),(19,'5','Vui lòng đến trước giờ bắt đầu 15\' !!',22,1,320000),(20,'2','Vui lòng đến trước giờ bắt đầu 15\' !!',23,1,320000),(21,'1','Vui lòng đến trước giờ bắt đầu 15\' !!',24,2,160000);
/*!40000 ALTER TABLE `app_ticketdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_trip`
--

DROP TABLE IF EXISTS `app_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_trip` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `blank_seat` int NOT NULL,
  `driver_id` bigint DEFAULT NULL,
  `line_id` bigint DEFAULT NULL,
  `extra_changes` decimal(8,0) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_trip_driver_id_e5b4c114_fk_app_user_id` (`driver_id`),
  KEY `app_trip_line_id_c0545e25_fk_app_line_id` (`line_id`),
  CONSTRAINT `app_trip_driver_id_e5b4c114_fk_app_user_id` FOREIGN KEY (`driver_id`) REFERENCES `app_user` (`id`),
  CONSTRAINT `app_trip_line_id_c0545e25_fk_app_line_id` FOREIGN KEY (`line_id`) REFERENCES `app_line` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_trip`
--

LOCK TABLES `app_trip` WRITE;
/*!40000 ALTER TABLE `app_trip` DISABLE KEYS */;
INSERT INTO `app_trip` VALUES (2,'Chuyến 2','2021-08-10 11:28:40.000000','2021-08-10 12:30:47.000000',0,12,2,0,1),(4,'Chuyến 4','2021-08-10 13:27:44.000000','2021-08-10 13:27:46.000000',0,12,3,0,1),(5,'Chuyến 5','2021-08-10 16:25:31.000000','2021-08-10 16:25:32.000000',3,12,3,0,1),(6,'Chuyến TPHCM - Đà Lạt','2021-08-22 10:10:00.000000','2021-08-22 16:10:00.000000',0,12,2,0,1),(7,'Chuyến Tây Ninh - TPHCM','2021-08-23 10:10:00.000000','2021-08-23 16:10:00.000000',39,16,5,10000,1);
/*!40000 ALTER TABLE `app_trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_user`
--

DROP TABLE IF EXISTS `app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `dob` datetime(6) DEFAULT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `identity_card` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `number_phone` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_user`
--

LOCK TABLES `app_user` WRITE;
/*!40000 ALTER TABLE `app_user` DISABLE KEYS */;
INSERT INTO `app_user` VALUES (1,'pbkdf2_sha256$260000$g8Nde76Le0vDWA98CK0Zho$+LV1m/zpXpR5/dc8hiYF3RMAz+5QORBvpm4q3F4nFQA=','2021-12-22 14:53:39.502091',1,'admin','Nguyễn Giám','Đốc','admin@gmail.com',1,1,'2021-07-29 15:10:57.000000','2021-07-29 15:31:23.000000','nam','abc','123456789','0123456789','image/upload/v1629554503/snaxv4qt47vbjmssn1gw.png'),(11,'pbkdf2_sha256$260000$mhZdKR0PZlNQEFjV0KKdHz$Oa3z3b8le7pOY6loyVvE5Ud8mDMVi9L9wj5gbD2mqK0=',NULL,0,'tuduong','tu','duong','tuduong@gmail.com',0,1,'2021-08-04 19:07:24.000000',NULL,NULL,NULL,NULL,NULL,'image/upload/v1629554903/qt56a5iis1ofvftfljwc.jpg'),(12,'pbkdf2_sha256$260000$HZUyXbXiStCdfNSFpfOCkS$WoqaTMaTTCbgq6X9hY0i5CQhJJ5wf6EbOmFz6RQsGMA=',NULL,0,'driver1','tai','xe','taixe@gmail.com',0,1,'2021-08-06 09:26:01.494327',NULL,NULL,NULL,NULL,NULL,''),(13,'pbkdf2_sha256$260000$vIWMjCMSGJzymHGvshazvK$jZLE07Ux1XBt11pxhMxGhdwLdF2V5QZCSGkFchxkIIs=',NULL,0,'khachhang1','khach','hang','khachhang@gmail.com',0,1,'2021-08-06 13:51:55.289051',NULL,NULL,NULL,NULL,NULL,''),(14,'pbkdf2_sha256$260000$orxHDhFC67OzFZB19XfwEL$Ad3dpTTe92hrUQlnGJeVQPA1CX8rX/a0C3LJE+PQ1fE=',NULL,0,'khachhang2','khach2','hang2','khachhang@gmail.com',0,1,'2021-08-06 14:12:01.612645',NULL,NULL,NULL,NULL,NULL,''),(15,'pbkdf2_sha256$260000$qGwUOYyUfJ7d0hDPEjYVCJ$sDP+ddDwwB6XMLsHOyl1JH7Aulm96tkNu3tOMH5umxc=',NULL,0,'employee1','nhan1','vien1','tuduong@gmail.com',0,1,'2021-08-07 14:15:58.471398',NULL,NULL,NULL,NULL,NULL,''),(16,'pbkdf2_sha256$260000$TCBPQy0nyC1IkinXqTaX2L$C6Dl3YKOQ1Jmxbk10fMhmRp6YPEoLXjettT+yCwpcJE=',NULL,0,'driver2','tai','xe 2','taixe2@gmail.com',0,1,'2021-08-21 10:08:21.805844',NULL,NULL,NULL,NULL,NULL,'images/2021/08/book2.png');
/*!40000 ALTER TABLE `app_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_user_groups`
--

DROP TABLE IF EXISTS `app_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_user_groups_user_id_group_id_73b8e940_uniq` (`user_id`,`group_id`),
  KEY `app_user_groups_group_id_e774d92c_fk_auth_group_id` (`group_id`),
  CONSTRAINT `app_user_groups_group_id_e774d92c_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `app_user_groups_user_id_e6f878f6_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_user_groups`
--

LOCK TABLES `app_user_groups` WRITE;
/*!40000 ALTER TABLE `app_user_groups` DISABLE KEYS */;
INSERT INTO `app_user_groups` VALUES (13,11,2),(6,12,2),(7,12,3),(8,13,2),(9,14,2),(11,15,1),(10,15,2),(12,16,2);
/*!40000 ALTER TABLE `app_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_user_user_permissions`
--

DROP TABLE IF EXISTS `app_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_user_user_permissions_user_id_permission_id_7c8316ce_uniq` (`user_id`,`permission_id`),
  KEY `app_user_user_permis_permission_id_4ef8e133_fk_auth_perm` (`permission_id`),
  CONSTRAINT `app_user_user_permis_permission_id_4ef8e133_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `app_user_user_permissions_user_id_24780b52_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_user_user_permissions`
--

LOCK TABLES `app_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `app_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_vehicle`
--

DROP TABLE IF EXISTS `app_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_vehicle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `license_plate` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `seat` int NOT NULL,
  `vehicle_type_id` bigint DEFAULT NULL,
  `extra_changes` int NOT NULL,
  `driver_id` bigint DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_vehicle_license_plate_a26b8962_uniq` (`license_plate`),
  UNIQUE KEY `app_vehicle_driver_id_94d417de_uniq` (`driver_id`),
  KEY `app_vehicle_vehicle_type_id_4b6e48f8_fk_app_vehicletype_id` (`vehicle_type_id`),
  CONSTRAINT `app_vehicle_driver_id_94d417de_fk_app_user_id` FOREIGN KEY (`driver_id`) REFERENCES `app_user` (`id`),
  CONSTRAINT `app_vehicle_vehicle_type_id_4b6e48f8_fk_app_vehicletype_id` FOREIGN KEY (`vehicle_type_id`) REFERENCES `app_vehicletype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_vehicle`
--

LOCK TABLES `app_vehicle` WRITE;
/*!40000 ALTER TABLE `app_vehicle` DISABLE KEYS */;
INSERT INTO `app_vehicle` VALUES (1,'59A1-123456',5,1,0,12,1),(2,'59B1-098778',40,4,50000,16,1);
/*!40000 ALTER TABLE `app_vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_vehicletype`
--

DROP TABLE IF EXISTS `app_vehicletype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_vehicletype` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name_type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_vehicletype_name_type_45eded59_uniq` (`name_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_vehicletype`
--

LOCK TABLES `app_vehicletype` WRITE;
/*!40000 ALTER TABLE `app_vehicletype` DISABLE KEYS */;
INSERT INTO `app_vehicletype` VALUES (1,'Xe 4 -5 chổ'),(2,'Xe 7 chổ'),(4,'Xe giường nằm');
/*!40000 ALTER TABLE `app_vehicletype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'customer'),(3,'driver'),(1,'employee');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (26,1,25),(23,1,26),(27,1,27),(28,1,29),(22,1,30),(25,1,31),(3,1,34),(4,1,35),(38,1,38),(7,1,44),(8,1,48),(29,1,49),(24,1,50),(30,1,51),(20,2,21),(21,2,22),(19,2,24),(15,2,28),(11,2,32),(36,2,33),(12,2,36),(37,2,37),(13,2,40),(14,2,52),(31,2,73),(32,2,74),(33,2,75),(34,2,76);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add line',7,'add_line'),(26,'Can change line',7,'change_line'),(27,'Can delete line',7,'delete_line'),(28,'Can view line',7,'view_line'),(29,'Can add point',8,'add_point'),(30,'Can change point',8,'change_point'),(31,'Can delete point',8,'delete_point'),(32,'Can view point',8,'view_point'),(33,'Can add ticket',9,'add_ticket'),(34,'Can change ticket',9,'change_ticket'),(35,'Can delete ticket',9,'delete_ticket'),(36,'Can view ticket',9,'view_ticket'),(37,'Can add ticket detail',10,'add_ticketdetail'),(38,'Can change ticket detail',10,'change_ticketdetail'),(39,'Can delete ticket detail',10,'delete_ticketdetail'),(40,'Can view ticket detail',10,'view_ticketdetail'),(41,'Can add vehicle type',11,'add_vehicletype'),(42,'Can change vehicle type',11,'change_vehicletype'),(43,'Can delete vehicle type',11,'delete_vehicletype'),(44,'Can view vehicle type',11,'view_vehicletype'),(45,'Can add vehicle',12,'add_vehicle'),(46,'Can change vehicle',12,'change_vehicle'),(47,'Can delete vehicle',12,'delete_vehicle'),(48,'Can view vehicle',12,'view_vehicle'),(49,'Can add trip',13,'add_trip'),(50,'Can change trip',13,'change_trip'),(51,'Can delete trip',13,'delete_trip'),(52,'Can view trip',13,'view_trip'),(53,'Can add application',14,'add_application'),(54,'Can change application',14,'change_application'),(55,'Can delete application',14,'delete_application'),(56,'Can view application',14,'view_application'),(57,'Can add access token',15,'add_accesstoken'),(58,'Can change access token',15,'change_accesstoken'),(59,'Can delete access token',15,'delete_accesstoken'),(60,'Can view access token',15,'view_accesstoken'),(61,'Can add grant',16,'add_grant'),(62,'Can change grant',16,'change_grant'),(63,'Can delete grant',16,'delete_grant'),(64,'Can view grant',16,'view_grant'),(65,'Can add refresh token',17,'add_refreshtoken'),(66,'Can change refresh token',17,'change_refreshtoken'),(67,'Can delete refresh token',17,'delete_refreshtoken'),(68,'Can view refresh token',17,'view_refreshtoken'),(69,'Can add id token',18,'add_idtoken'),(70,'Can change id token',18,'change_idtoken'),(71,'Can delete id token',18,'delete_idtoken'),(72,'Can view id token',18,'view_idtoken'),(73,'Can add feed back',19,'add_feedback'),(74,'Can change feed back',19,'change_feedback'),(75,'Can delete feed back',19,'delete_feedback'),(76,'Can view feed back',19,'view_feedback');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_520_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_app_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-07-29 15:16:00.448777','1','VehicleType object (1)',1,'[{\"added\": {}}]',11,1),(2,'2021-07-29 15:20:10.561319','1','Xe 59A1-123456',1,'[{\"added\": {}}]',12,1),(3,'2021-07-29 15:43:27.160235','1','admin',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Dob\", \"Gender\", \"Address\", \"Identity card\", \"Number phone\", \"Avatar\"]}}]',6,1),(4,'2021-07-29 16:12:50.971131','1','admin',2,'[{\"changed\": {\"fields\": [\"Avatar\"]}}]',6,1),(5,'2021-07-30 13:40:48.931466','2','Xe 7 chổ',1,'[{\"added\": {}}]',11,1),(6,'2021-07-30 13:41:11.861196','3','Xe 7 chổ',1,'[{\"added\": {}}]',11,1),(7,'2021-07-30 13:41:19.692063','3','Xe 7 chổ',3,'',11,1),(8,'2021-07-30 14:38:06.609462','1','TP Hồ Chí Minh',1,'[{\"added\": {}}]',8,1),(9,'2021-07-30 14:38:31.657663','2','Tây Ninh',1,'[{\"added\": {}}]',8,1),(10,'2021-07-30 14:46:04.376007','1','Tuyến Tây Ninh - TPHCM',1,'[{\"added\": {}}]',7,1),(11,'2021-07-30 14:50:02.090424','1','Chuyến 1',1,'[{\"added\": {}}]',13,1),(12,'2021-07-30 15:14:24.690866','1','Tây Ninh - TPHCM',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',7,1),(13,'2021-07-30 15:14:56.040950','1','Chuyến 1 ngày',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',13,1),(14,'2021-07-30 15:19:20.669936','2','customer1',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Last login\", \"Avatar\"]}}]',6,1),(15,'2021-07-30 15:19:39.180525','2','customer1',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]',6,1),(16,'2021-07-30 15:19:57.158402','3','emplyee1',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Avatar\"]}}]',6,1),(17,'2021-07-30 15:21:34.882141','1','Ticket object (1)',1,'[{\"added\": {}}]',9,1),(18,'2021-07-30 15:24:46.294255','2','Ticket object (2)',1,'[{\"added\": {}}]',9,1),(19,'2021-07-30 15:53:19.456990','1','TicketDetail object (1)',1,'[{\"added\": {}}]',10,1),(20,'2021-07-30 16:54:40.677088','1','Chuyến 1 ngày hôm nay',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',13,1),(21,'2021-08-02 16:13:17.640439','2','customer1',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',6,1),(24,'2021-08-03 16:15:12.428549','4','',3,'',6,1),(25,'2021-08-03 16:19:32.102323','6','tuduong1',3,'',6,1),(26,'2021-08-03 16:21:00.378799','5','tuduong',3,'',6,1),(27,'2021-08-04 15:38:04.802199','1','employee',1,'[{\"added\": {}}]',3,1),(28,'2021-08-04 16:27:11.484849','2','customer',1,'[{\"added\": {}}]',3,1),(29,'2021-08-04 16:28:10.777719','3','driver',1,'[{\"added\": {}}]',3,1),(30,'2021-08-04 16:28:25.408926','3','driver',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(31,'2021-08-04 17:46:53.114187','2','customer',2,'[{\"added\": {\"name\": \"user-group relationship\", \"object\": \"User_groups object (1)\"}}, {\"added\": {\"name\": \"user-group relationship\", \"object\": \"User_groups object (2)\"}}]',3,1),(32,'2021-08-04 18:17:05.200976','9','nguyenb',3,'',6,1),(33,'2021-08-04 18:17:05.355969','8','tranvana',3,'',6,1),(34,'2021-08-04 18:17:05.689957','7','tuduong',3,'',6,1),(35,'2021-08-05 16:19:01.597920','1','employee',2,'[{\"added\": {\"name\": \"user-group relationship\", \"object\": \"User_groups object (5)\"}}]',3,1),(36,'2021-08-06 09:26:23.861090','3','driver',2,'[{\"added\": {\"name\": \"user-group relationship\", \"object\": \"User_groups object (7)\"}}]',3,1),(37,'2021-08-06 13:24:08.936294','2','customer1',3,'',6,1),(38,'2021-08-06 13:24:09.454315','3','emplyee1',3,'',6,1),(39,'2021-08-06 13:24:55.142591','10','tuduong',3,'',6,1),(40,'2021-08-06 13:52:28.867958','2','customer',2,'[{\"deleted\": {\"name\": \"user-group relationship\", \"object\": \"User_groups object (None)\"}}]',3,1),(41,'2021-08-07 12:27:08.766277','2','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(42,'2021-08-07 14:18:39.289371','1','employee',2,'[{\"added\": {\"name\": \"user-group relationship\", \"object\": \"User_groups object (11)\"}}]',3,1),(43,'2021-08-07 14:25:21.334780','1','employee',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(44,'2021-08-07 15:10:54.368345','1','employee',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(45,'2021-08-07 15:11:10.609809','1','employee',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(46,'2021-08-07 16:00:18.761761','1','TicketDetail object (1)',3,'',10,1),(47,'2021-08-07 16:00:37.408714','2','Vé Chuyến 1 ngày hôm nay',2,'[{\"changed\": {\"fields\": [\"Employee\", \"Customer\"]}}]',9,1),(48,'2021-08-07 16:00:55.262567','2','Vé Chuyến 1 ngày hôm nay',2,'[{\"added\": {\"name\": \"ticket detail\", \"object\": \"TicketDetail object (2)\"}}]',9,1),(49,'2021-08-08 07:45:46.612092','3','Tây Ninh',1,'[{\"added\": {}}]',8,1),(50,'2021-08-08 07:46:24.135271','4','Lâm Đồng',1,'[{\"added\": {}}]',8,1),(51,'2021-08-08 07:46:42.774877','4','Đà Lạt',2,'[{\"changed\": {\"fields\": [\"Address\"]}}]',8,1),(52,'2021-08-08 07:46:50.726645','5','TP Vũng Tàu',1,'[{\"added\": {}}]',8,1),(53,'2021-08-08 07:55:31.941826','2','TPHCM - Đà Lạt',1,'[{\"added\": {}}]',7,1),(54,'2021-08-08 07:55:41.867272','1','Tây Ninh - TPHCM',2,'[{\"changed\": {\"fields\": [\"Extra charges\"]}}]',7,1),(55,'2021-08-08 08:13:13.641340','3','Đà Lạt - TPHCM',1,'[{\"added\": {}}]',7,1),(56,'2021-08-08 08:13:23.069813','3','Đà Lạt - TPHCM',2,'[{\"changed\": {\"fields\": [\"Extra charges\"]}}]',7,1),(57,'2021-08-08 08:39:31.133803','1','employee',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(58,'2021-08-08 08:59:14.720311','1','employee',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(59,'2021-08-08 09:23:34.333403','1','employee',2,'[]',3,1),(60,'2021-08-08 09:39:36.628425','1','employee',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(61,'2021-08-08 10:17:23.291554','4','manager',1,'[{\"added\": {}}]',3,1),(62,'2021-08-08 10:22:31.832585','4','manager',3,'',3,1),(63,'2021-08-09 08:17:27.004343','1','Xe 59A1-123456',2,'[{\"changed\": {\"fields\": [\"Driver\"]}}]',12,1),(64,'2021-08-09 10:39:20.644474','2','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(65,'2021-08-09 11:10:49.784200','2','FeedBack object (2)',3,'',19,1),(66,'2021-08-09 16:54:00.119662','1','Chuyến 1 ngày hôm nay',2,'[{\"changed\": {\"fields\": [\"Driver\"]}}]',13,1),(67,'2021-08-10 11:29:50.937947','2','Chuyến 2',1,'[{\"added\": {}}]',13,1),(68,'2021-08-10 13:22:23.274884','3','Chuyến 3',1,'[{\"added\": {}}]',13,1),(69,'2021-08-10 13:27:48.997366','4','Chuyến 4',1,'[{\"added\": {}}]',13,1),(70,'2021-08-10 14:05:04.595579','6','Vé Chuyến 1 ngày hôm nay',1,'[{\"added\": {}}]',9,1),(71,'2021-08-10 14:14:50.633713','11','Vé Chuyến 1 ngày hôm nay',3,'',9,1),(72,'2021-08-10 16:01:26.215712','1','Tây Ninh - TPHCM',2,'[{\"changed\": {\"fields\": [\"Start point\"]}}]',7,1),(73,'2021-08-10 16:25:44.222945','5','Chuyến 5',1,'[{\"added\": {}}]',13,1),(74,'2021-08-20 17:51:08.102409','6','Vĩnh Phúc',1,'[{\"added\": {}}]',8,1),(75,'2021-08-20 18:39:16.337322','2','Chuyến 2',2,'[{\"changed\": {\"fields\": [\"Line\"]}}]',13,1),(76,'2021-08-20 18:39:21.806994','4','Chuyến 4',2,'[{\"changed\": {\"fields\": [\"Line\"]}}]',13,1),(77,'2021-08-21 09:37:01.009343','9','Vé Chuyến 1 ngày hôm nay',2,'[{\"changed\": {\"fields\": [\"Employee\", \"Customer\"]}}]',9,1),(78,'2021-08-21 09:37:15.219573','13','Vé Chuyến 2',2,'[{\"changed\": {\"fields\": [\"Employee\", \"Customer\"]}}]',9,1),(79,'2021-08-21 09:41:56.066064','11','tuduong',2,'[{\"changed\": {\"fields\": [\"Username\", \"Avatar\"]}}]',6,1),(80,'2021-08-21 09:52:00.156255','4','TPHCM - Tây Ninh',1,'[{\"added\": {}}]',7,1),(81,'2021-08-21 10:02:41.074716','5','Chuyến 5',2,'[{\"changed\": {\"fields\": [\"Extra changes\"]}}]',13,1),(82,'2021-08-21 10:02:47.461393','3','Chuyến 3',2,'[{\"changed\": {\"fields\": [\"Extra changes\"]}}]',13,1),(83,'2021-08-21 10:02:59.726682','1','Tây Ninh - TPHCM',2,'[{\"changed\": {\"fields\": [\"Price\"]}}]',7,1),(84,'2021-08-21 10:03:07.105270','4','TPHCM - Tây Ninh',2,'[{\"changed\": {\"fields\": [\"Price\"]}}]',7,1),(85,'2021-08-21 10:03:14.576858','3','Đà Lạt - TPHCM',2,'[{\"changed\": {\"fields\": [\"Price\"]}}]',7,1),(86,'2021-08-21 10:03:19.658623','2','TPHCM - Đà Lạt',2,'[{\"changed\": {\"fields\": [\"Price\"]}}]',7,1),(87,'2021-08-21 10:04:03.125961','4','Xe giường nằm',1,'[{\"added\": {}}]',11,1),(88,'2021-08-21 10:08:53.865213','2','Xe 59B1-098778',1,'[{\"added\": {}}]',12,1),(89,'2021-08-21 10:29:05.375038','1','Chuyến 1',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',13,1),(90,'2021-08-21 14:01:43.360087','1','admin',2,'[{\"changed\": {\"fields\": [\"Avatar\"]}}]',6,1),(91,'2021-08-21 14:08:22.603957','11','tuduong',2,'[{\"changed\": {\"fields\": [\"Avatar\"]}}]',6,1),(92,'2021-08-21 15:14:22.872665','11','tuduong',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',6,1),(93,'2021-08-21 16:50:45.336722','1','employee',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(94,'2021-08-22 14:59:26.230336','8','Tây Ninh - Đà Lạt',3,'',7,1),(95,'2021-08-22 14:59:33.916101','7','Tây Ninh - Đà Lạt',3,'',7,1),(96,'2021-08-22 15:07:49.190043','3','Chuyến 3',3,'',13,1),(97,'2021-08-22 15:07:49.304985','1','Chuyến 1',3,'',13,1),(98,'2021-08-22 16:46:54.537636','2','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(99,'2021-08-22 16:47:29.843961','2','customer',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(100,'2021-08-22 16:51:37.325487','1','employee',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(101,'2021-08-22 17:53:45.181898','8','TicketDetail object (8)',3,'',10,1),(102,'2021-08-22 17:53:45.283857','7','TicketDetail object (7)',3,'',10,1),(103,'2021-08-22 17:53:45.371854','6','TicketDetail object (6)',3,'',10,1),(104,'2021-08-22 17:53:45.437850','5','TicketDetail object (5)',3,'',10,1),(105,'2021-08-22 17:53:45.544849','4','TicketDetail object (4)',3,'',10,1),(106,'2021-08-22 17:53:45.693836','3','TicketDetail object (3)',3,'',10,1),(107,'2021-08-22 17:55:12.447792','10','Vé None',3,'',9,1),(108,'2021-08-22 17:55:12.514731','9','Vé None',3,'',9,1),(109,'2021-08-22 17:55:12.669733','8','Vé None',3,'',9,1),(110,'2021-08-22 17:55:12.921709','7','Vé None',3,'',9,1),(111,'2021-08-22 17:55:13.009703','6','Vé None',3,'',9,1),(112,'2021-08-22 17:55:13.158697','5','Vé None',3,'',9,1),(113,'2021-08-22 17:55:13.276746','4','Vé None',3,'',9,1),(114,'2021-08-22 17:55:13.443765','3','Vé None',3,'',9,1),(115,'2021-08-23 09:24:54.662407','2','customer',2,'[]',3,1),(116,'2021-08-23 11:00:51.105297','6','Phản hồi về Chuyến 2 ngày 10-8-2021 của user khachhang1',3,'',19,1),(117,'2021-08-23 11:00:51.201192','5','Phản hồi về Chuyến 2 ngày 10-8-2021 của user khachhang1',3,'',19,1),(118,'2021-08-23 11:00:51.311191','4','Phản hồi về Chuyến 2 ngày 10-8-2021 của user khachhang1',3,'',19,1),(119,'2021-08-23 11:00:51.425184','3','Phản hồi về Chuyến 2 ngày 10-8-2021 của user khachhang1',3,'',19,1),(120,'2021-08-23 11:00:51.532177','2','Phản hồi về Chuyến 2 ngày 10-8-2021 của user khachhang1',3,'',19,1),(121,'2021-08-23 11:00:51.639209','1','Phản hồi về None của user khachhang2',3,'',19,1),(122,'2021-08-23 12:14:20.374371','5','Tây Ninh - TPHCM',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',7,1),(123,'2021-08-23 12:15:03.892565','7','Chuyến Tây Ninh - TPHCM ngày 23-8-2021',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',13,1),(124,'2021-08-23 16:30:25.159555','3','driver',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(19,'app','feedback'),(7,'app','line'),(8,'app','point'),(9,'app','ticket'),(10,'app','ticketdetail'),(13,'app','trip'),(6,'app','user'),(12,'app','vehicle'),(11,'app','vehicletype'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(15,'oauth2_provider','accesstoken'),(14,'oauth2_provider','application'),(16,'oauth2_provider','grant'),(18,'oauth2_provider','idtoken'),(17,'oauth2_provider','refreshtoken'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-07-29 13:56:29.155399'),(2,'contenttypes','0002_remove_content_type_name','2021-07-29 13:56:33.206229'),(3,'auth','0001_initial','2021-07-29 13:56:49.650270'),(4,'auth','0002_alter_permission_name_max_length','2021-07-29 13:56:51.655218'),(5,'auth','0003_alter_user_email_max_length','2021-07-29 13:56:51.796150'),(6,'auth','0004_alter_user_username_opts','2021-07-29 13:56:51.903198'),(7,'auth','0005_alter_user_last_login_null','2021-07-29 13:56:52.059177'),(8,'auth','0006_require_contenttypes_0002','2021-07-29 13:56:52.333179'),(9,'auth','0007_alter_validators_add_error_messages','2021-07-29 13:56:52.458174'),(10,'auth','0008_alter_user_username_max_length','2021-07-29 13:56:52.586164'),(11,'auth','0009_alter_user_last_name_max_length','2021-07-29 13:56:52.672101'),(12,'auth','0010_alter_group_name_max_length','2021-07-29 13:56:53.011110'),(13,'auth','0011_update_proxy_permissions','2021-07-29 13:56:53.282068'),(14,'auth','0012_alter_user_first_name_max_length','2021-07-29 13:56:53.421065'),(15,'app','0001_initial','2021-07-29 13:57:52.873834'),(16,'admin','0001_initial','2021-07-29 13:58:03.518210'),(17,'admin','0002_logentry_remove_auto_add','2021-07-29 13:58:03.768241'),(18,'admin','0003_logentry_add_action_flag_choices','2021-07-29 13:58:04.055176'),(19,'sessions','0001_initial','2021-07-29 13:58:05.644090'),(20,'app','0002_auto_20210730_2223','2021-07-30 15:24:14.445040'),(21,'app','0003_auto_20210730_2352','2021-07-30 16:52:25.170564'),(22,'oauth2_provider','0001_initial','2021-08-02 17:13:52.449715'),(23,'oauth2_provider','0002_auto_20190406_1805','2021-08-02 17:13:55.569739'),(24,'oauth2_provider','0003_auto_20201211_1314','2021-08-02 17:13:58.935250'),(25,'oauth2_provider','0004_auto_20200902_2022','2021-08-02 17:14:22.364957'),(26,'app','0004_auto_20210807_2256','2021-08-07 15:57:52.963257'),(27,'app','0005_alter_ticketdetail_ticket','2021-08-07 16:21:23.081558'),(28,'app','0006_auto_20210808_1724','2021-08-08 10:24:45.295809'),(30,'app','0007_feedback','2021-08-09 11:27:48.766172'),(31,'app','0008_auto_20210810_0104','2021-08-09 18:04:59.775201'),(32,'app','0009_auto_20210821_1658','2021-08-21 09:58:33.625487'),(33,'app','0010_alter_user_avatar','2021-08-21 14:00:55.534392'),(34,'app','0011_alter_line_unique_together','2021-08-22 14:59:49.325140'),(35,'app','0012_alter_feedback_unique_together','2021-08-23 11:02:01.847574'),(36,'app','0013_auto_20210823_2158','2021-08-23 14:58:44.554255');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('arhcxbsmvecucx77jfv35ek4lldqk005','.eJxVjE0OwiAYRO_C2hBAoODSvWcgfD-VqqFJaVfGu1uSLnQ5b97MW6S8rSVtjZc0kbgILU6_DDI-ufaCHrneZ4lzXZcJZFfk0TZ5m4lf18P9Oyi5lb72HBXSoD1APoM1pIgdmDA64D2B1RExBG2dt8Gj1byjrNwQYzCjE58v-bs31A:1mBIN9:8GG9jichM1LtjETdnoxnsFlBk8SydUFfz4i_8qZkL18','2021-08-18 14:59:55.839680'),('eo56ztefj2zfaj4y09d023jdts65vc5b','.eJxVjE0OwiAYRO_C2hBAoODSvWcgfD-VqqFJaVfGu1uSLnQ5b97MW6S8rSVtjZc0kbgILU6_DDI-ufaCHrneZ4lzXZcJZFfk0TZ5m4lf18P9Oyi5lb72HBXSoD1APoM1pIgdmDA64D2B1RExBG2dt8Gj1byjrNwQYzCjE58v-bs31A:1mH7tG:qmYpOPapfmJcvPraaUq1hlC12dB5HALB0e8VAS9DZEY','2021-09-03 17:01:10.246318'),('g2ldbgjcnpuiy9q9hhrmb5pbuhkspvau','.eJxVjE0OwiAYRO_C2hBAoODSvWcgfD-VqqFJaVfGu1uSLnQ5b97MW6S8rSVtjZc0kbgILU6_DDI-ufaCHrneZ4lzXZcJZFfk0TZ5m4lf18P9Oyi5lb72HBXSoD1APoM1pIgdmDA64D2B1RExBG2dt8Gj1byjrNwQYzCjE58v-bs31A:1n02zr:V9XBpXjleZmJtWfC-awqptRPOjov5dgqmrGzWXi0mJo','2022-01-05 14:53:39.651140');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_app_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_accesstoken` VALUES (22,'ST34IIfUmg68IPbwBWrKnaxGEHp9lt','2021-08-06 23:51:11.281913','read write',2,1,'2021-08-06 13:51:11.282882','2021-08-06 13:51:11.282882',NULL,NULL),(23,'yLXnUMu0WpQtbC6MhpHX7B1yzII58g','2021-08-07 00:24:54.934565','read write',2,13,'2021-08-06 14:24:54.934565','2021-08-06 14:24:54.934565',NULL,NULL),(24,'aZet9zIQA2Hi6lJg14RvLzk6YlCmb0','2021-08-07 22:42:00.023385','read write',2,13,'2021-08-07 12:42:00.024389','2021-08-07 12:42:00.024389',NULL,NULL),(25,'64HZAbBEkkGIsLoKiIs8huVuhWrEcT','2021-08-08 00:15:42.925299','read write',2,1,'2021-08-07 14:15:42.926298','2021-08-07 14:15:42.926298',NULL,NULL),(26,'3fogurY2SeDV8Azg0Ay7eG6yNxVMl0','2021-08-08 00:26:40.806800','read write',2,15,'2021-08-07 14:26:40.807800','2021-08-07 14:26:40.807800',NULL,NULL),(27,'kp1YNdaKMgiMBFBtZdF2XcnLgSVJbf','2021-08-08 19:13:05.800031','read write',2,15,'2021-08-08 09:13:05.800031','2021-08-08 09:13:05.800031',NULL,NULL),(28,'ZR9pwhzR4HI2pq6zSzme6Cnn83pyG7','2021-08-09 20:25:30.267312','read write',2,15,'2021-08-09 10:25:30.268335','2021-08-09 10:25:30.268335',NULL,NULL),(29,'nGxviXTLCdrCHuqipvhnnLnnOZP2uJ','2021-08-09 21:11:11.061325','read write',2,14,'2021-08-09 11:11:11.062309','2021-08-09 11:11:11.062309',NULL,NULL),(30,'cmbg4kGlWiLNqB2dDo5b1YkQtSyDX1','2021-08-10 21:49:18.069803','read write',2,13,'2021-08-10 11:49:18.069803','2021-08-10 11:49:18.069803',NULL,NULL),(31,'at5nZHBcXr8PDrCI3ZovAJynPbqzTF','2021-08-11 03:35:12.390549','read write',2,15,'2021-08-10 17:35:12.391547','2021-08-10 17:35:12.391547',NULL,NULL),(32,'fIRkuvvTORp5b4zFNtlvcOYzF578Ip','2021-08-11 03:37:35.735840','read write',2,13,'2021-08-10 17:37:35.736883','2021-08-10 17:37:35.736883',NULL,NULL),(33,'enWp3gu9QMouhwgiSHx97ux6RHP59O','2021-08-21 03:15:04.154267','read write',2,13,'2021-08-20 17:15:04.155267','2021-08-20 17:15:04.155267',NULL,NULL),(34,'Ze0PjRiGPiNUGUaCAmHFODZpdaqQfq','2021-08-21 05:28:37.321423','read write',2,13,'2021-08-20 19:28:37.322421','2021-08-20 19:28:37.322421',NULL,NULL),(35,'tQG3qkGX5C5yNHeSp5UCddFxWOjll7','2021-08-21 16:43:23.044270','read write',2,13,'2021-08-21 06:43:23.045272','2021-08-21 06:43:23.045272',NULL,NULL),(36,'Mku5WfaVKaRHHDZqknDxkmp691xsYo','2021-08-21 16:47:57.033175','read write',2,14,'2021-08-21 06:47:57.034160','2021-08-21 06:47:57.034160',NULL,NULL),(37,'sNqoVODyC2L7duxygwSL8a7G1gCK8n','2021-08-21 17:21:57.455552','read write',2,13,'2021-08-21 07:21:57.456553','2021-08-21 07:21:57.456553',NULL,NULL),(38,'CWJNXSb93r75H8NBpMh5chwFuDwWg0','2021-08-21 19:38:15.862203','read write',2,15,'2021-08-21 09:38:15.863189','2021-08-21 09:38:15.863189',NULL,NULL),(39,'m1ceRTkDKQ9xKE5bpvUJDi2gwM7Ojs','2021-08-21 19:43:14.769257','read write',2,11,'2021-08-21 09:43:14.770290','2021-08-21 09:43:14.770290',NULL,NULL),(40,'6JGxtFx8TosYGG7XMGd28EacW84rjN','2021-08-22 01:12:03.407471','read write',2,11,'2021-08-21 15:12:03.409437','2021-08-21 15:12:03.409437',NULL,NULL),(41,'wgHsIiPUxEuVccpszjl105hlNSehSM','2021-08-22 01:23:58.806953','read write',2,15,'2021-08-21 15:23:58.806953','2021-08-21 15:23:58.807967',NULL,NULL),(42,'MSYMoOwKmswZ4HZ3QgEpQJkXNpBYyW','2021-08-22 02:33:35.051964','read write',2,12,'2021-08-21 16:33:35.052996','2021-08-21 16:33:35.052996',NULL,NULL),(43,'wtygXLVbQfrHmvex7QBrk4uedYpeeD','2021-08-22 02:35:27.841133','read write',2,11,'2021-08-21 16:35:27.842133','2021-08-21 16:35:27.842133',NULL,NULL),(44,'QczI1THwHvk51Pl38NgfbvqNQ6cbHv','2021-08-22 02:39:02.049046','read write',2,13,'2021-08-21 16:39:02.050048','2021-08-21 16:39:02.050048',NULL,NULL),(45,'g6aFIG4VkdnIvnZOJrOuBlxawLx6t5','2021-08-22 02:39:16.992569','read write',2,15,'2021-08-21 16:39:16.993569','2021-08-21 16:39:16.993569',NULL,NULL),(46,'czM9hKBvCYt1ljsXloKo1ElA8p37kg','2021-08-22 02:40:28.676227','read write',2,13,'2021-08-21 16:40:28.677228','2021-08-21 16:40:28.677228',NULL,NULL),(47,'DDY60FqAjD9ILF2TpydJeYCgkgT39C','2021-08-22 02:40:51.214518','read write',2,1,'2021-08-21 16:40:51.214518','2021-08-21 16:40:51.214518',NULL,NULL),(48,'vwqtklkyqbbSxWKQJRi6SOvfTGuoD8','2021-08-22 02:44:34.147337','read write',2,11,'2021-08-21 16:44:34.148337','2021-08-21 16:44:34.148337',NULL,NULL),(49,'l0XGGuPlHm99gXlBfWagy3tR5UeQoA','2021-08-22 03:04:14.704866','read write',2,15,'2021-08-21 17:04:14.705868','2021-08-21 17:04:14.705868',NULL,NULL),(50,'WertMbEq0QmaSvyT8VZ1tQF6Lep7MK','2021-08-22 03:39:15.330114','read write',2,15,'2021-08-21 17:39:15.331114','2021-08-21 17:39:15.331114',NULL,NULL),(51,'RL6uK5Ly971t6exirtA8cNHqZpIQvO','2021-08-23 00:23:36.548229','read write',2,15,'2021-08-22 14:23:36.549226','2021-08-22 14:23:36.549226',NULL,NULL),(52,'l9XkTTOhuY69JKcJCU0YNHaNcjk4RG','2021-08-23 02:56:50.709648','read write',2,13,'2021-08-22 16:56:50.710650','2021-08-22 16:56:50.710650',NULL,NULL),(53,'rmxqP7ZeKsOiojGaQFVC0iIjHs6xOL','2021-08-23 19:34:41.847607','read write',2,14,'2021-08-23 09:34:41.848613','2021-08-23 09:34:41.848613',NULL,NULL),(54,'oR6H0PFV5LMADgMiN5rVQsW7A5EIB6','2021-08-23 19:45:05.410277','read write',2,13,'2021-08-23 09:45:05.411276','2021-08-23 09:45:05.411276',NULL,NULL),(55,'epH6vOUK5hpvZWmRH4XJmbxg91pfIH','2021-08-23 21:34:07.996404','read write',2,13,'2021-08-23 11:34:07.996404','2021-08-23 11:34:07.996404',NULL,NULL),(56,'nQsPG1zAAK5hD4VFOJ5djxos7nG2Ej','2021-08-23 21:49:52.920593','read write',2,15,'2021-08-23 11:49:52.921595','2021-08-23 11:49:52.921595',NULL,NULL),(57,'ZxOr5Vr6jIkp3lxw1OqSGXSqsT6ZXO','2021-08-23 22:31:16.643277','read write',2,14,'2021-08-23 12:31:16.644277','2021-08-23 12:31:16.644277',NULL,NULL),(58,'p3L4ne4bYlzjqqP1FbczMKBIOfctKS','2021-08-24 01:47:25.271290','read write',2,14,'2021-08-23 15:47:25.271290','2021-08-23 15:47:25.271290',NULL,NULL),(59,'BiKH7CIp9NjDKbMtoWBkJBKpAOTIYO','2021-08-24 01:47:51.164701','read write',2,13,'2021-08-23 15:47:51.165758','2021-08-23 15:47:51.165758',NULL,NULL),(60,'95t2Ri2NKDPDFKsA44J8IoTwiPz6Op','2021-08-24 02:27:16.129438','read write',2,15,'2021-08-23 16:27:16.130434','2021-08-23 16:27:16.130434',NULL,NULL);
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `client_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `authorization_grant_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `client_secret` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_application_user_id_79829054_fk_app_user_id` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_application_user_id_79829054_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
INSERT INTO `oauth2_provider_application` VALUES (2,'CzCDhKiM7r9ogvDUoDD1nhgBuHiD1jAAyechfzrB','','confidential','password','aR9W92KJ2uHxcJpaTYeodgn4jDdogGMloTeJWiaAIKIBoqHRm9QwlY4XSc56g3kr0MF4RtGJ6N6S462uqCb45gjXrKZX1GQYXjJRhqkikss9Al8ES7XsY0cw9ZzmjwPC','appbookticket',1,0,'2021-08-06 13:50:41.780156','2021-08-06 13:50:41.780156','');
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `code_challenge_method` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `claims` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_app_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_idtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idtoken_user_id_dd512b59_fk_app_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_idtoken`
--

LOCK TABLES `oauth2_provider_idtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refreshtoken_user_id_da837fce_fk_app_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refreshtoken_user_id_da837fce_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
INSERT INTO `oauth2_provider_refreshtoken` VALUES (22,'8iX8aTzHNnWLyu9HrRX8vWC55vyHnk',22,2,1,'2021-08-06 13:51:11.353920','2021-08-06 13:51:11.353920',NULL),(23,'5xlTpPGoVfQJNny3o63ZewKdIpnsMS',23,2,13,'2021-08-06 14:24:55.000758','2021-08-06 14:24:55.000758',NULL),(24,'GPkMFA58gAqRA0n9RjUCu0WPyQMNsO',24,2,13,'2021-08-07 12:42:00.073415','2021-08-07 12:42:00.073415',NULL),(25,'niaXAmaaeW2E1QAEnAFuw4QUv2I0bA',25,2,1,'2021-08-07 14:15:42.969263','2021-08-07 14:15:42.969263',NULL),(26,'oZbVWcjNP0lmudw2glZU4mE5cn26rz',26,2,15,'2021-08-07 14:26:40.847800','2021-08-07 14:26:40.847800',NULL),(27,'WSrf44LQJI1FDwyHH12ruhQDGbh7G7',27,2,15,'2021-08-08 09:13:05.891033','2021-08-08 09:13:05.891033',NULL),(28,'X3DBlls6RyrCA9UDtzFyDk3OrRCWJj',28,2,15,'2021-08-09 10:25:30.488179','2021-08-09 10:25:30.489160',NULL),(29,'lI3cQVS3ggRMa3W8GcOSKgB37IlpBr',29,2,14,'2021-08-09 11:11:11.152305','2021-08-09 11:11:11.152305',NULL),(30,'D0veCgXgJMHP2RSIwFQ7rXrFZk0AJn',30,2,13,'2021-08-10 11:49:18.272951','2021-08-10 11:49:18.272951',NULL),(31,'0CDdCvZ4FDxnzZHJcW4f6CY8yQU7u2',31,2,15,'2021-08-10 17:35:12.943645','2021-08-10 17:35:12.944606',NULL),(32,'LlTO9vc3w34VJOtPNHxuk4VR86JNc6',32,2,13,'2021-08-10 17:37:35.854833','2021-08-10 17:37:35.854833',NULL),(33,'F7Er4tsQIV5qpr8QEW1YeRVn0vKLWJ',33,2,13,'2021-08-20 17:15:04.239263','2021-08-20 17:15:04.239263',NULL),(34,'UI7K998Eb9ukKvIpzjtq8IhtzRMqS6',34,2,13,'2021-08-20 19:28:37.340406','2021-08-20 19:28:37.340406',NULL),(35,'gNypGxxFhJO49kRO07jq7kw7tqxlqG',35,2,13,'2021-08-21 06:43:23.069269','2021-08-21 06:43:23.069269',NULL),(36,'UeYTXWXo8Q7DaXfTcpAhY8jNvXZrEk',36,2,14,'2021-08-21 06:47:57.044163','2021-08-21 06:47:57.044163',NULL),(37,'DlbhZeQ3ZV7xmNg3aYAb0QLooyAWgG',37,2,13,'2021-08-21 07:21:57.481552','2021-08-21 07:21:57.481552',NULL),(38,'LnARRXu9z459mznjl4n81hmHNUlIWX',38,2,15,'2021-08-21 09:38:15.892167','2021-08-21 09:38:15.892167',NULL),(39,'4K2ZYjH6aAXS25aZVBwEfQyJ84SKtX',39,2,11,'2021-08-21 09:43:14.802256','2021-08-21 09:43:14.802256',NULL),(40,'4cUWALpjZ4RQvwPNqqbFg5Qj1FPL1O',40,2,11,'2021-08-21 15:12:03.478438','2021-08-21 15:12:03.478438',NULL),(41,'bDj55FxtWxJEYX2xfFhkyu2AT7392f',41,2,15,'2021-08-21 15:23:58.840950','2021-08-21 15:23:58.840950',NULL),(42,'I6OaPHvGvlwiafq2pkn94RSDY5EyRt',42,2,12,'2021-08-21 16:33:35.079962','2021-08-21 16:33:35.079962',NULL),(43,'ipdUn912VE6r9geBqCAzmeEbRiLcqQ',43,2,11,'2021-08-21 16:35:27.855132','2021-08-21 16:35:27.855132',NULL),(44,'b27M6KNPd1JfAaasx7x2cDGo71AxTs',44,2,13,'2021-08-21 16:39:02.058033','2021-08-21 16:39:02.058033',NULL),(45,'w99F61sCMNXjNdBGsg2TJWQLNS9DiE',45,2,15,'2021-08-21 16:39:17.029568','2021-08-21 16:39:17.029568',NULL),(46,'7BaSBCGmFvp4hWCa6eSS2nEsnUiRiv',46,2,13,'2021-08-21 16:40:28.702227','2021-08-21 16:40:28.702227',NULL),(47,'dCQLLvHLTdqRB1WbmS4tLa9ehkakZs',47,2,1,'2021-08-21 16:40:51.223521','2021-08-21 16:40:51.223521',NULL),(48,'3Z1FNsPxPEhrDfxIFPPev4oVyqqYXX',48,2,11,'2021-08-21 16:44:34.489381','2021-08-21 16:44:34.489381',NULL),(49,'rCHphxUJxoLAPqGEaXUFk1IRUTHsIU',49,2,15,'2021-08-21 17:04:14.728848','2021-08-21 17:04:14.728848',NULL),(50,'8qFq8vUMX9XcW6qrGQPQ4TxEl5IsHC',50,2,15,'2021-08-21 17:39:15.365098','2021-08-21 17:39:15.365098',NULL),(51,'2lVaAtkwIpn4gGE5KWm7vpbVBlqrkd',51,2,15,'2021-08-22 14:23:36.615200','2021-08-22 14:23:36.615200',NULL),(52,'SYfPjfUQWcoTiANxiz91TRJgLXJ43L',52,2,13,'2021-08-22 16:56:50.737602','2021-08-22 16:56:50.737602',NULL),(53,'Ci0fIPu0xKceCSTkZU8SxriVyLvo91',53,2,14,'2021-08-23 09:34:41.960599','2021-08-23 09:34:41.960599',NULL),(54,'MvrMsNIgziU4MWe1glcIYbP6bO9Kgn',54,2,13,'2021-08-23 09:45:05.421248','2021-08-23 09:45:05.421248',NULL),(55,'HCdVOG9N78aeBzF1ppcT57WT63psU0',55,2,13,'2021-08-23 11:34:08.018181','2021-08-23 11:34:08.018181',NULL),(56,'69f1WbXjfaUEPm212BKnVzfMvM7eqW',56,2,15,'2021-08-23 11:49:52.941619','2021-08-23 11:49:52.941619',NULL),(57,'09CtqHrfbn1euvFossiAFZQPzJiATx',57,2,14,'2021-08-23 12:31:16.672297','2021-08-23 12:31:16.672297',NULL),(58,'CflwxFD5M8QqwkS7jY7DLmpCO5RYbK',58,2,14,'2021-08-23 15:47:25.286975','2021-08-23 15:47:25.286975',NULL),(59,'mRzHFgPnsNYBnCdTs4lPFw7AzbtzXX',59,2,13,'2021-08-23 15:47:51.175758','2021-08-23 15:47:51.175758',NULL),(60,'s3qdnjd7DRiDeV37QzAsudeSMDVPLY',60,2,15,'2021-08-23 16:27:16.141434','2021-08-23 16:27:16.141434',NULL);
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-23 14:45:45
