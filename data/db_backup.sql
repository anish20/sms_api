-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sms_db
-- ------------------------------------------------------
-- Server version	8.0.38

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
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `path` varchar(100) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'Dashboard','/dashboard','dashboard',NULL,1),(2,'User Management','/users','users',NULL,1),(3,'Reports','/reports','report',NULL,1),(4,'Settings','/settings','settings',NULL,1),(5,'General Settings','/settings/general','cog',4,1),(6,'Security Settings','/settings/security','lock',4,1);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_menu_map`
--

DROP TABLE IF EXISTS `role_menu_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_menu_map` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int DEFAULT NULL,
  `menu_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `role_menu_map_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `role_menu_map_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu_map`
--

LOCK TABLES `role_menu_map` WRITE;
/*!40000 ALTER TABLE `role_menu_map` DISABLE KEYS */;
INSERT INTO `role_menu_map` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(8,2,1),(9,2,3),(10,3,1),(11,3,3),(12,4,1),(13,4,2);
/*!40000 ALTER TABLE `role_menu_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(4,'manager'),(2,'student'),(3,'teacher');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `refresh_token` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin User','admin@example.com','$2b$10$D9hYHDVobV.69Q.NWftf0e3SUnvpFd7wUzXPtKTu3Ox/ZvYd85ZSG','admin',NULL,NULL,'2025-08-05 06:04:33','2025-08-05 06:04:33',NULL),(2,'Student User','student@example.com','$2b$10$D9hYHDVobV.69Q.NWftf0e3SUnvpFd7wUzXPtKTu3Ox/ZvYd85ZSG','student',NULL,NULL,'2025-08-05 06:04:33','2025-08-05 06:04:33',NULL),(3,'Manager User','manager@example.com','$2b$10$D9hYHDVobV.69Q.NWftf0e3SUnvpFd7wUzXPtKTu3Ox/ZvYd85ZSG','manager',NULL,NULL,'2025-08-05 06:04:33','2025-08-05 06:04:33',NULL),(4,'Teacher User','teacher@example.com','$2b$10$D9hYHDVobV.69Q.NWftf0e3SUnvpFd7wUzXPtKTu3Ox/ZvYd85ZSG','teacher',NULL,NULL,'2025-08-05 06:04:33','2025-08-05 06:04:33',NULL),(5,'Anish Developer','anish@example.com','$2b$10$nfS7cZVXOLa2KJD2mntT7ePk9S.kxFMsV9KrnomnUVCHAvS8Tga1u','admin',NULL,NULL,'2025-08-05 06:46:02','2025-08-05 09:42:35','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNzU0Mzg2OTU1LCJleHAiOjE3NTQ5OTE3NTV9.agdbu47pzUcvOBvlxg0UvSkWjq3mOh9UXnMB5_BiTxs'),(6,'Manish','manish.student@example.com','$2b$10$TbBTUPpAoxiW9vdcJzvxm.g4MTfpL14jN0hSiJHV0/zzG.ESXO6Zy','student',NULL,NULL,'2025-08-05 08:01:44','2025-08-05 08:19:12','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzU0MzgxOTUyLCJleHAiOjE3NTQ5ODY3NTJ9.kvoD1dFVyYd_vOK4mJM48av3LsjeRJsMx2KQT5ECGTI');
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

-- Dump completed on 2025-08-05 15:38:53
