-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: sistem_ases_dan_barang_inventaris_kantor
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asset_transactions`
--

DROP TABLE IF EXISTS `asset_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_transactions` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `transaction_type` enum('purchase','transfer','maintenance','scrap') NOT NULL,
  `from_department_id` int(11) DEFAULT NULL,
  `to_department_id` int(11) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transactions_asset` (`asset_id`),
  KEY `fk_transactions_from_dept` (`from_department_id`),
  KEY `fk_transactions_to_dept` (`to_department_id`),
  KEY `fk_transactions_user` (`created_by`),
  CONSTRAINT `fk_transactions_asset` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_transactions_from_dept` FOREIGN KEY (`from_department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_transactions_to_dept` FOREIGN KEY (`to_department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_transactions_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_transactions`
--

LOCK TABLES `asset_transactions` WRITE;
/*!40000 ALTER TABLE `asset_transactions` DISABLE KEYS */;
INSERT INTO `asset_transactions` VALUES (1,1,'purchase',NULL,1,'2024-01-15','Pembelian laptop baru untuk tim IT',1,'2026-06-24 14:30:26'),(2,2,'purchase',NULL,2,'2024-02-10','PC untuk staff HRD',1,'2026-06-24 14:30:26'),(3,4,'maintenance',NULL,NULL,'2024-06-20','Servis rutin printer',3,'2026-06-24 14:30:26'),(4,5,'purchase',NULL,1,'2023-12-01','Server baru untuk infrastruktur',1,'2026-06-24 14:30:26'),(5,8,'transfer',1,1,'2024-06-15','Router rusak dipindah ke ruang server untuk perbaikan',7,'2026-06-24 14:30:26'),(6,9,'purchase',NULL,5,'2022-08-15','Kendaraan operasional untuk tim operations',1,'2026-06-24 14:30:26'),(7,10,'transfer',1,4,'2024-04-05','Laptop dipindah ke departemen marketing',2,'2026-06-24 14:30:26');
/*!40000 ALTER TABLE `asset_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `asset_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_code` varchar(50) NOT NULL,
  `asset_name` varchar(150) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `purchase_date` date NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `status` enum('aktif','rusak','maintenance','scrap') DEFAULT 'aktif',
  `asset_condition` enum('baik','sedang','buruk') DEFAULT 'baik',
  `last_maintenance` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`asset_id`),
  UNIQUE KEY `asset_code` (`asset_code`),
  KEY `fk_assets_category` (`category_id`),
  KEY `fk_assets_location` (`location_id`),
  KEY `fk_assets_department` (`department_id`),
  CONSTRAINT `fk_assets_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `fk_assets_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_assets_location` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (1,'AST-001','Laptop Dell XPS 15',1,'Laptop untuk developer','2024-01-15',25000000.00,1,1,'aktif','baik','2024-06-01','2026-06-24 14:23:13','2026-06-24 14:23:13'),(2,'AST-002','Desktop PC HP',1,'PC untuk administrasi','2024-02-10',8000000.00,5,2,'aktif','baik','2024-05-15','2026-06-24 14:23:13','2026-06-24 14:23:13'),(3,'AST-003','Meja Kerja Manager',2,'Meja kerja kayu jati','2023-06-20',5000000.00,1,1,'aktif','sedang',NULL,'2026-06-24 14:23:13','2026-06-24 14:23:13'),(4,'AST-004','Printer Canon IR',3,'Printer multifunction','2024-03-05',15000000.00,6,3,'maintenance','baik','2024-06-20','2026-06-24 14:23:13','2026-06-24 14:23:13'),(5,'AST-005','Server Dell PowerEdge',5,'Server utama perusahaan','2023-12-01',75000000.00,2,1,'aktif','baik','2024-06-15','2026-06-24 14:23:13','2026-06-24 14:23:13'),(6,'AST-006','Kursi Ergonomis',2,'Kursi kerja ergonomis','2024-01-20',3500000.00,5,2,'aktif','baik',NULL,'2026-06-24 14:23:13','2026-06-24 14:23:13'),(7,'AST-007','Monitor LG 27',1,'Monitor LED 27 inch','2024-02-15',4500000.00,1,1,'aktif','baik',NULL,'2026-06-24 14:23:13','2026-06-24 14:23:13'),(8,'AST-008','Router Cisco',5,'Router jaringan utama','2023-11-10',12000000.00,2,1,'rusak','buruk','2024-04-10','2026-06-24 14:23:13','2026-06-24 14:23:13'),(9,'AST-009','Mobil Operasional',4,'Toyota Avanza','2022-08-15',250000000.00,4,5,'aktif','sedang','2024-06-10','2026-06-24 14:23:13','2026-06-24 14:23:13'),(10,'AST-010','Laptop Lenovo',1,'Laptop untuk marketing','2024-04-01',12000000.00,7,4,'aktif','baik',NULL,'2026-06-24 14:23:13','2026-06-24 14:23:13'),(11,'AST-011','Proyektor Epson',1,'Proyektor untuk meeting','2024-01-10',8500000.00,3,1,'aktif','baik','2024-05-20','2026-06-24 14:23:13','2026-06-24 14:23:13'),(12,'AST-012','Lemari Arsip',2,'Lemari besi untuk dokumen','2023-09-05',6000000.00,6,3,'aktif','sedang',NULL,'2026-06-24 14:23:13','2026-06-24 14:23:13');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `action` enum('create','update','delete') NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `record_id` int(11) NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`log_id`),
  KEY `fk_audit_user` (`user_id`),
  CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,1,'create','Assets',1,NULL,'Laptop Dell XPS 15','2026-06-24 14:30:41'),(2,1,'create','Assets',2,NULL,'Desktop PC HP','2026-06-24 14:30:41'),(3,3,'update','Assets',4,'status: aktif','status: maintenance','2026-06-24 14:30:41'),(4,1,'create','Users',5,NULL,'karyawan_budi','2026-06-24 14:30:41'),(5,7,'update','Assets',8,'condition: sedang','condition: buruk','2026-06-24 14:30:41');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Electronics','Perangkat elektronik dan komputer'),(2,'Furniture','Mebel dan perabot kantor'),(3,'Office Supplies','Peralatan kantor'),(4,'Vehicles','Kendaraan operasional'),(5,'Network Equipment','Peralatan jaringan');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_name` (`department_name`),
  KEY `fk_departments_manager` (`manager_id`),
  CONSTRAINT `fk_departments_manager` FOREIGN KEY (`manager_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'IT Department',7,'2026-06-24 14:11:39','2026-06-24 14:14:03'),(2,'Human Resources',2,'2026-06-24 14:11:39','2026-06-24 14:13:31'),(3,'Finance',NULL,'2026-06-24 14:11:39','2026-06-24 14:11:39'),(4,'Marketing',NULL,'2026-06-24 14:11:39','2026-06-24 14:11:39'),(5,'Operations',NULL,'2026-06-24 14:11:39','2026-06-24 14:11:39');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(100) NOT NULL,
  `building` varchar(50) NOT NULL,
  `floor` varchar(10) NOT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `uk_location` (`location_name`,`building`,`floor`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (6,'Ruang Finance','Gedung B','Lantai 3'),(5,'Ruang HRD','Gedung B','Lantai 2'),(1,'Ruang Kepala IT','Gedung A','Lantai 2'),(7,'Ruang Marketing','Gedung A','Lantai 3'),(3,'Ruang Rapat Utama','Gedung B','Lantai 1'),(2,'Ruang Server','Gedung A','Lantai 1'),(4,'Warehouse','Gedung C','Lantai 1');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','manager','staff','karyawan') NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `status` enum('aktif','inactive') DEFAULT 'aktif',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_users_department` (`department_id`),
  CONSTRAINT `fk_users_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin_john','john@company.com','admin123','admin',1,'aktif','2026-06-24 14:12:47','2026-06-24 14:12:47'),(2,'manager_sarah','sarah@company.com','manager123','manager',2,'aktif','2026-06-24 14:12:47','2026-06-24 14:12:47'),(3,'staff_mike','mike@company.com','staff123','staff',1,'aktif','2026-06-24 14:12:47','2026-06-24 14:12:47'),(4,'staff_lisa','lisa@company.com','staff123','staff',3,'aktif','2026-06-24 14:12:47','2026-06-24 14:12:47'),(5,'karyawan_budi','budi@company.com','karyawan123','karyawan',4,'aktif','2026-06-24 14:12:47','2026-06-24 14:12:47'),(6,'karyawan_ani','ani@company.com','karyawan123','karyawan',5,'aktif','2026-06-24 14:12:47','2026-06-24 14:12:47'),(7,'manager_it','manager.it@company.com','manager123','manager',1,'aktif','2026-06-24 14:12:47','2026-06-24 14:12:47');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-24 21:47:18
