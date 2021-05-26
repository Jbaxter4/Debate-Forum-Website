-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: comp5013
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `comp5013`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `comp5013` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `comp5013`;

--
-- Table structure for table `claimrelations`
--

DROP TABLE IF EXISTS `claimrelations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `claimrelations` (
  `claimID` int unsigned DEFAULT NULL,
  `claimHeader` varchar(50) DEFAULT NULL,
  `relatedToID` int unsigned DEFAULT NULL,
  `oppOrEqu` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claimrelations`
--

LOCK TABLES `claimrelations` WRITE;
/*!40000 ALTER TABLE `claimrelations` DISABLE KEYS */;
INSERT INTO `claimrelations` VALUES (2,'Labour are good',1,'opposed'),(1,'They are all useless',2,'opposed'),(3,'Tories are good',1,'opposed'),(1,'They are all useless',3,'opposed'),(4,'Tories are bad',1,'equivalent'),(1,'They are all useless',4,'equivalent'),(4,'Tories are bad',3,'opposed'),(3,'Tories are good',4,'opposed');
/*!40000 ALTER TABLE `claimrelations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `claims`
--

DROP TABLE IF EXISTS `claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `claims` (
  `claimID` int unsigned NOT NULL AUTO_INCREMENT,
  `claimHeader` varchar(50) DEFAULT NULL,
  `posterName` varchar(20) DEFAULT NULL,
  `posterTime` datetime DEFAULT NULL,
  `parentTopic` int unsigned DEFAULT NULL,
  PRIMARY KEY (`claimID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claims`
--

LOCK TABLES `claims` WRITE;
/*!40000 ALTER TABLE `claims` DISABLE KEYS */;
INSERT INTO `claims` VALUES (1,'They are all useless','James','2020-05-25 09:31:50',1),(2,'Labour are good','Fred','2020-05-25 12:57:05',1),(3,'Tories are good','Fred','2020-05-25 12:57:49',1),(4,'Tories are bad','Fred','2020-05-25 12:58:07',1),(5,'Arsenal are great','James','2020-05-25 13:45:25',2);
/*!40000 ALTER TABLE `claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replys`
--

DROP TABLE IF EXISTS `replys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replys` (
  `replyID` int unsigned NOT NULL AUTO_INCREMENT,
  `replyContent` varchar(200) DEFAULT NULL,
  `posterName` varchar(20) DEFAULT NULL,
  `posterTime` datetime DEFAULT NULL,
  `parentClaim` int unsigned DEFAULT NULL,
  `parentReply` int unsigned DEFAULT NULL,
  `claimResponse` varchar(18) DEFAULT NULL,
  `replyResponse` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`replyID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replys`
--

LOCK TABLES `replys` WRITE;
/*!40000 ALTER TABLE `replys` DISABLE KEYS */;
INSERT INTO `replys` VALUES (1,'Yes','James','2020-05-25 09:32:07',1,NULL,'supporting',NULL);
/*!40000 ALTER TABLE `replys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `topicID` int unsigned NOT NULL AUTO_INCREMENT,
  `topicName` varchar(30) DEFAULT NULL,
  `posterName` varchar(20) DEFAULT NULL,
  `posterTime` datetime DEFAULT NULL,
  PRIMARY KEY (`topicID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` VALUES (1,'Politics','James','2020-05-25 09:31:01'),(2,'Football','James','2020-05-25 09:31:11'),(3,'Baseball','Fred','2020-05-25 13:07:01'),(4,'New Topic','James','2020-05-25 15:37:22'),(5,'Neww Topic','James','2020-05-25 16:11:57');
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'James','Password'),(2,'Fred','fredpassword'),(3,'ExampleUser','ExamplePass'),(4,'wenfuerngu','wefwassad');
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

-- Dump completed on 2020-05-25 17:50:24
