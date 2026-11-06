-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: biometric
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
-- Current Database: `biometric`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `biometric` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `biometric`;

--
-- Table structure for table `admin_security`
--

DROP TABLE IF EXISTS `admin_security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_security` (
  `ADMIN_USER` varchar(50) NOT NULL,
  `SECURITY_QUESTION` varchar(255) NOT NULL,
  `SECURITY_ANSWER` varchar(255) NOT NULL,
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ADMIN_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_security`
--

LOCK TABLES `admin_security` WRITE;
/*!40000 ALTER TABLE `admin_security` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_security` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `ADMIN_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ADMIN_USER` varchar(50) NOT NULL,
  `ADMIN_PASS` varchar(100) NOT NULL,
  PRIMARY KEY (`ADMIN_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (3,'admin@biometrics.com','$2y$10$XjPs1sCrvbcuZhvl0v1jwewYFcd/9Tke5ZJ3Laz5hFXLY4cebIZqy');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STUDENT_ID` varchar(50) NOT NULL,
  `STUDENT_NAME` varchar(100) NOT NULL,
  `GRADE_SNAPSHOT` tinyint(3) unsigned DEFAULT NULL,
  `STRAND_SNAPSHOT` varchar(20) NOT NULL DEFAULT '',
  `SECTION_SNAPSHOT` varchar(80) NOT NULL DEFAULT '',
  `TIME_IN` datetime DEFAULT current_timestamp(),
  `ATTENDANCE_DATE` date GENERATED ALWAYS AS (cast(`TIME_IN` as date)) STORED,
  `LUNCH_OUT` datetime DEFAULT NULL,
  `AFTERNOON_TIME_IN` datetime DEFAULT NULL,
  `TIME_OUT` datetime DEFAULT NULL,
  `ATTENDANCE_REMARK` varchar(40) DEFAULT NULL,
  `ATTENDANCE_NOTE` varchar(255) DEFAULT NULL,
  `IS_AUTO_ABSENT` tinyint(1) NOT NULL DEFAULT 0,
  `ATTENDANCE_UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UX_ATTENDANCE_STUDENT_DAY` (`STUDENT_ID`,`ATTENDANCE_DATE`)
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (37,'24356','jovs',7,'Academic','Camia','2026-05-06 14:43:04','2026-05-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(39,'2023-02028','Shamil M. Santiago',7,'Academic','Camia','2026-05-06 14:59:02','2026-05-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(41,'2023-00157','Lanie Rose S. Elvambuena',7,'','Camia','2026-05-06 15:02:02','2026-05-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(42,'2023-01967','Jomarie O. Fajardo',7,'','Camia','2026-05-06 15:08:26','2026-05-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(43,'4941561','Agirs',7,'','Orchids','2026-05-06 15:29:44','2026-05-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(59,'123456','Sherly Concepcion',7,'Academic','Camia','2026-05-07 05:44:25','2026-05-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(64,'2023-02028','Shamil M. Santiago',7,'Academic','Camia','2026-05-07 08:33:22','2026-05-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(65,'3718236','Joven Diego',NULL,'','','2026-05-07 08:33:58','2026-05-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(67,'2023-820056','John Julius Concepcion',7,'Academic','Camia','2026-05-07 08:42:49','2026-05-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(68,'2023-00228','Benedict Garis',7,'Academic','Camia','2026-05-07 09:02:19','2026-05-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(69,'2026-012345','Marian Dela Cruz',7,'Academic','Camia','2026-05-07 09:13:14','2026-05-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(70,'2026-123456','Benito',7,'Academic','Camia','2026-05-07 14:21:51','2026-05-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(71,'123456','Sherly Concepcion',7,'Academic','Camia','2026-09-06 20:15:10','2026-09-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(72,'2023-820056','John Julius Concepcion',7,'Academic','Camia','2026-09-06 20:18:13','2026-09-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(73,'3718236','Joven Diego',NULL,'','','2026-09-06 20:28:16','2026-09-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(74,'2023-00157','Lanie Rose S. Elvambuena',7,'','Camia','2026-09-06 20:41:00','2026-09-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(75,'2023-00228','Benedict Garis',7,'Academic','Camia','2026-09-06 21:16:18','2026-09-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(76,'2023-02028','Shamil M. Santiago',7,'Academic','Camia','2026-09-06 21:23:58','2026-09-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(77,'2023-01967','Jomarie O. Fajardo',7,'','Camia','2026-09-06 21:31:10','2026-09-06',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(78,'2023-820056','John Julius Concepcion',7,'Academic','Camia','2026-09-07 12:47:37','2026-09-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(79,'2023-820056','John Julius Concepcion',7,'Academic','Camia','2026-09-08 07:23:16','2026-09-08',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(80,'3718236','Joven Diego',NULL,'','','2026-09-08 07:36:25','2026-09-08',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(81,'24356','jovs',7,'Academic','Camia','2026-09-08 08:18:55','2026-09-08',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(82,'2023-00228','Benedict Garis',7,'Academic','Camia','2026-09-08 15:13:13','2026-09-08',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(83,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-08 15:38:43','2026-09-08',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(84,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-09 09:12:00','2026-09-09',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(85,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-10 06:41:08','2026-09-10',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(86,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-11 11:45:35','2026-09-11',NULL,NULL,'2026-09-11 15:58:26',NULL,NULL,0,'2026-10-27 09:06:52'),(87,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-12 08:30:39','2026-09-12',NULL,NULL,'2026-09-12 10:29:38',NULL,NULL,0,'2026-10-27 09:06:52'),(88,'2023-00228','Benedict Garis',7,'Academic','Camia','2026-09-12 12:44:37','2026-09-12',NULL,NULL,'2026-09-12 16:28:53',NULL,NULL,0,'2026-10-27 09:06:52'),(89,'2023-00157','Lanie Rose S. Elvambuena',7,'','Camia','2026-09-12 16:39:29','2026-09-12',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(90,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-13 09:29:26','2026-09-13',NULL,NULL,'2026-09-13 09:55:25',NULL,NULL,0,'2026-10-27 09:06:52'),(91,'2026-0019','Cristalie Diego',11,'Academic','Kepler','2026-09-13 19:28:25','2026-09-13',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(92,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-14 10:46:29','2026-09-14',NULL,NULL,'2026-09-14 10:46:38',NULL,NULL,0,'2026-10-27 09:06:52'),(93,'2026-0019','Cristalie Diego',11,'Academic','Kepler','2026-09-14 18:07:00','2026-09-14',NULL,NULL,'2026-09-14 18:07:55',NULL,NULL,0,'2026-10-27 09:06:52'),(94,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-15 06:56:43','2026-09-15',NULL,NULL,'2026-09-15 06:57:13',NULL,NULL,0,'2026-10-27 09:06:52'),(95,'2023-820056','John Julius Concepcion',7,'Academic','Camia','2026-09-15 12:17:50','2026-09-15',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(96,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-16 09:40:39','2026-09-16',NULL,NULL,'2026-09-16 10:25:53',NULL,NULL,0,'2026-10-27 09:06:52'),(97,'2026-0020','Aries John Dela Cruz',9,'Techpro','Peace','2026-09-16 09:59:49','2026-09-16',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(98,'2026-0019','Cristalie Diego',11,'Academic','Kepler','2026-09-16 12:41:31','2026-09-16',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(99,'431','Red Zyricks miranda',10,'Techpro','Newton','2026-09-16 12:52:39','2026-09-16',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(100,'2026-0021','John harvie Dela Cruz',12,'Academic','Pythagoras','2026-09-16 13:27:19','2026-09-16',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(101,'456','Albien Garcia',8,'Academic','Amethyst','2026-09-16 14:39:37','2026-09-16',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(102,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-17 09:53:01','2026-09-17',NULL,NULL,'2026-09-17 10:12:33',NULL,NULL,0,'2026-10-27 09:06:52'),(103,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-21 16:45:55','2026-09-21',NULL,NULL,'2026-09-21 17:06:39',NULL,NULL,0,'2026-10-27 09:06:52'),(104,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-23 13:06:51','2026-09-23',NULL,NULL,'2026-09-23 13:06:55',NULL,NULL,0,'2026-10-27 09:06:52'),(105,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-26 10:54:24','2026-09-26',NULL,NULL,'2026-09-26 10:54:39',NULL,NULL,0,'2026-10-27 09:06:52'),(106,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-09-27 14:10:49','2026-09-27',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(483,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-10-06 15:25:56','2026-10-06',NULL,NULL,'2026-10-06 15:56:43',NULL,NULL,0,'2026-10-27 09:06:52'),(547,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-10-07 07:31:37','2026-10-07',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(735,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-10-11 10:05:19','2026-10-11',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(736,'191509180002','JOHN ABROGAR ACALA',8,'Academic','Amethyst','2026-10-12 00:00:00','2026-10-12',NULL,NULL,NULL,'Absent','Marked absent by teacher.',0,'2026-10-27 09:06:52'),(737,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-10-12 08:50:08','2026-10-12','2026-10-12 11:52:44','2026-10-12 19:24:41','2026-10-12 19:38:39',NULL,NULL,0,'2026-10-27 09:06:52'),(738,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-10-13 09:40:15','2026-10-13','2026-10-13 12:02:19','2026-10-13 14:07:51','2026-10-13 09:47:25',NULL,NULL,0,'2026-10-27 09:06:52'),(739,'1','Raven  Diego',8,'','Jade','2026-10-13 15:11:36','2026-10-13',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(740,'191509180002','JOHN ABROGAR ACALA',8,'Academic','Amethyst','2026-10-13 17:35:28','2026-10-13',NULL,NULL,NULL,'Marked present','Marked present by teacher',0,'2026-10-27 09:06:52'),(741,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-10-14 03:05:01','2026-10-14',NULL,NULL,'2026-10-14 19:52:24',NULL,NULL,0,'2026-10-27 09:06:52'),(742,'2023-00157','Lanie Rose S. Elvambuena',7,'','Camia','2026-10-14 20:48:00','2026-10-14',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(743,'2026-0018','Joven Diego',8,'Techpro','Jade','2026-10-15 10:41:48','2026-10-15',NULL,NULL,'2026-10-15 10:54:20',NULL,NULL,0,'2026-10-27 09:06:52'),(744,'2023-820056','John Julius  Concepion',7,'Academic','Camia','2026-10-15 12:06:09','2026-10-15',NULL,NULL,'2026-10-15 12:11:24',NULL,NULL,0,'2026-10-27 09:06:52'),(745,'2026-0019','Cristalie Diego',11,'Academic','Kepler','2026-10-15 12:06:28','2026-10-15',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(746,'2023-00228','Benedict Garis',7,'Academic','Camia','2026-10-15 12:07:37','2026-10-15',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(747,'2023-02028','Shamil M. Santiago',7,'Academic','Camia','2026-10-15 13:24:32','2026-10-15',NULL,NULL,'2026-10-15 13:32:06',NULL,NULL,0,'2026-10-27 09:06:52'),(748,'24356','jovs',7,'Academic','Camia','2026-10-15 13:44:18','2026-10-15',NULL,NULL,NULL,NULL,NULL,0,'2026-10-27 09:06:52'),(749,'3132','Lanie Rose S Elvambuena',12,'Techpro','Burbank','2026-10-15 13:46:35','2026-10-15',NULL,NULL,'2026-10-15 13:53:10',NULL,NULL,0,'2026-10-27 09:06:52');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_absence_settings`
--

DROP TABLE IF EXISTS `attendance_absence_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_absence_settings` (
  `ID` tinyint(3) unsigned NOT NULL,
  `ENABLED_FROM` date NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_absence_settings`
--

LOCK TABLES `attendance_absence_settings` WRITE;
/*!40000 ALTER TABLE `attendance_absence_settings` DISABLE KEYS */;
INSERT INTO `attendance_absence_settings` VALUES (1,'2026-09-26');
/*!40000 ALTER TABLE `attendance_absence_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_day_settings`
--

DROP TABLE IF EXISTS `attendance_day_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_day_settings` (
  `ID` tinyint(3) unsigned NOT NULL,
  `WHOLE_DAY_ENABLED` tinyint(1) NOT NULL DEFAULT 0,
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_day_settings`
--

LOCK TABLES `attendance_day_settings` WRITE;
/*!40000 ALTER TABLE `attendance_day_settings` DISABLE KEYS */;
INSERT INTO `attendance_day_settings` VALUES (1,1,'2026-10-16 11:36:00');
/*!40000 ALTER TABLE `attendance_day_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_scan_events`
--

DROP TABLE IF EXISTS `attendance_scan_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_scan_events` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ATTENDANCE_ID` int(10) unsigned DEFAULT NULL,
  `STUDENT_ID` varchar(50) DEFAULT NULL,
  `EVENT_TYPE` varchar(20) NOT NULL,
  `SCAN_RESULT` varchar(20) NOT NULL,
  `SCANNED_AT` datetime NOT NULL,
  `SCANNER_SOURCE` varchar(20) NOT NULL DEFAULT '',
  `SCANNER_ID` varchar(60) NOT NULL DEFAULT '',
  `SCANNER_NAME` varchar(80) NOT NULL DEFAULT '',
  `DETAIL` varchar(120) NOT NULL DEFAULT '',
  `GRADE_SNAPSHOT` tinyint(3) unsigned DEFAULT NULL,
  `STRAND_SNAPSHOT` varchar(20) NOT NULL DEFAULT '',
  `SECTION_SNAPSHOT` varchar(80) NOT NULL DEFAULT '',
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `IX_SCAN_EVENTS_STUDENT_TIME` (`STUDENT_ID`,`SCANNED_AT`),
  KEY `IX_SCAN_EVENTS_TIME` (`SCANNED_AT`),
  KEY `IX_SCAN_EVENTS_RESULT_TIME` (`SCAN_RESULT`,`SCANNED_AT`),
  KEY `IX_SCAN_EVENTS_SECTION` (`GRADE_SNAPSHOT`,`SECTION_SNAPSHOT`,`SCANNED_AT`),
  KEY `IX_SCAN_EVENTS_ATTENDANCE` (`ATTENDANCE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_scan_events`
--

LOCK TABLES `attendance_scan_events` WRITE;
/*!40000 ALTER TABLE `attendance_scan_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance_scan_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorized_mobile_scanners`
--

DROP TABLE IF EXISTS `authorized_mobile_scanners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorized_mobile_scanners` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SCANNER_NAME` varchar(80) NOT NULL,
  `SCANNER_ID` varchar(60) NOT NULL,
  `IS_ENABLED` tinyint(1) NOT NULL DEFAULT 1,
  `DISABLED_AT` datetime DEFAULT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SCANNER_ID` (`SCANNER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4952 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorized_mobile_scanners`
--

LOCK TABLES `authorized_mobile_scanners` WRITE;
/*!40000 ALTER TABLE `authorized_mobile_scanners` DISABLE KEYS */;
INSERT INTO `authorized_mobile_scanners` VALUES (1686,'samsung SM-A035F','ANDROID-9075F37C1FF87E51',1,NULL,'2026-10-16 11:49:42'),(1789,'Samsung','1',1,NULL,'2026-10-16 12:06:51'),(4394,'HUAWEI PPA-LX2','ANDROID-E3EB24AADCC6E917',1,NULL,'2026-10-28 05:55:27');
/*!40000 ALTER TABLE `authorized_mobile_scanners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `current_teacher_advisory_assignments`
--

DROP TABLE IF EXISTS `current_teacher_advisory_assignments`;
/*!50001 DROP VIEW IF EXISTS `current_teacher_advisory_assignments`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `current_teacher_advisory_assignments` AS SELECT
 1 AS `TEACHER_ID`,
  1 AS `SCHOOL_YEAR`,
  1 AS `SECTION_ID`,
  1 AS `GRADE`,
  1 AS `STRAND`,
  1 AS `SECTION` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `current_teacher_subject_assignments`
--

DROP TABLE IF EXISTS `current_teacher_subject_assignments`;
/*!50001 DROP VIEW IF EXISTS `current_teacher_subject_assignments`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `current_teacher_subject_assignments` AS SELECT
 1 AS `TEACHER_ID`,
  1 AS `GRADE`,
  1 AS `STRAND`,
  1 AS `SECTION`,
  1 AS `SUBJECT`,
  1 AS `SCHOOL_YEAR` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `imported_adviser_assignments`
--

DROP TABLE IF EXISTS `imported_adviser_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imported_adviser_assignments` (
  `ADVISER_KEY` varchar(255) NOT NULL,
  `ADVISER_NAME` varchar(160) NOT NULL,
  `GRADE` tinyint(3) unsigned NOT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `SECTION` varchar(80) NOT NULL,
  `IMPORTED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  `SCHOOL_YEAR` varchar(20) NOT NULL DEFAULT '2026-2027',
  PRIMARY KEY (`ADVISER_KEY`,`SCHOOL_YEAR`,`GRADE`,`STRAND`,`SECTION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imported_adviser_assignments`
--

LOCK TABLES `imported_adviser_assignments` WRITE;
/*!40000 ALTER TABLE `imported_adviser_assignments` DISABLE KEYS */;
INSERT INTO `imported_adviser_assignments` VALUES ('HAZEL CHARISE LEONCIO','HAZEL CHARISE G. LEONCIO',8,'','Amethyst','2026-09-23 15:07:22','2026-2027');
/*!40000 ALTER TABLE `imported_adviser_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_scanner_settings`
--

DROP TABLE IF EXISTS `mobile_scanner_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_scanner_settings` (
  `ID` tinyint(3) unsigned NOT NULL,
  `SERVER_URL` varchar(255) NOT NULL DEFAULT '',
  `SCANNER_NAME` varchar(80) NOT NULL DEFAULT '',
  `SCANNER_ID` varchar(60) NOT NULL DEFAULT '',
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_scanner_settings`
--

LOCK TABLES `mobile_scanner_settings` WRITE;
/*!40000 ALTER TABLE `mobile_scanner_settings` DISABLE KEYS */;
INSERT INTO `mobile_scanner_settings` VALUES (1,'http://192.168.1.102/biometric-system/','Samsung','1','2026-10-30 04:39:44');
/*!40000 ALTER TABLE `mobile_scanner_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion_honor_sections`
--

DROP TABLE IF EXISTS `promotion_honor_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotion_honor_sections` (
  `GRADE` tinyint(3) unsigned NOT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `SECTION_ID` int(11) NOT NULL,
  PRIMARY KEY (`GRADE`,`STRAND`),
  UNIQUE KEY `SECTION_ID` (`SECTION_ID`),
  CONSTRAINT `promotion_honor_sections_ibfk_1` FOREIGN KEY (`SECTION_ID`) REFERENCES `sections` (`SECTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion_honor_sections`
--

LOCK TABLES `promotion_honor_sections` WRITE;
/*!40000 ALTER TABLE `promotion_honor_sections` DISABLE KEYS */;
INSERT INTO `promotion_honor_sections` VALUES (8,'',7),(9,'',9),(10,'',12);
/*!40000 ALTER TABLE `promotion_honor_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion_required_subjects`
--

DROP TABLE IF EXISTS `promotion_required_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotion_required_subjects` (
  `SCHOOL_YEAR` varchar(20) NOT NULL,
  `GRADE` tinyint(3) unsigned NOT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `SUBJECT` varchar(80) NOT NULL,
  PRIMARY KEY (`SCHOOL_YEAR`,`GRADE`,`STRAND`,`SUBJECT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion_required_subjects`
--

LOCK TABLES `promotion_required_subjects` WRITE;
/*!40000 ALTER TABLE `promotion_required_subjects` DISABLE KEYS */;
INSERT INTO `promotion_required_subjects` VALUES ('2026-2027',7,'','Araling Panlipunan'),('2026-2027',7,'','English'),('2026-2027',7,'','Filipino'),('2026-2027',7,'','MAPEH'),('2026-2027',7,'','Math'),('2026-2027',7,'','Science'),('2026-2027',7,'','TLE'),('2026-2027',7,'','Values Education'),('2026-2027',8,'','Araling Panlipunan'),('2026-2027',8,'','English'),('2026-2027',8,'','Filipino'),('2026-2027',8,'','MAPEH'),('2026-2027',8,'','Math'),('2026-2027',8,'','Science'),('2026-2027',8,'','TLE'),('2026-2027',8,'','Values Education'),('2026-2027',9,'','Araling Panlipunan'),('2026-2027',9,'','English'),('2026-2027',9,'','Filipino'),('2026-2027',9,'','MAPEH'),('2026-2027',9,'','Math'),('2026-2027',9,'','Science'),('2026-2027',9,'','TLE'),('2026-2027',9,'','Values Education'),('2026-2027',10,'','Araling Panlipunan'),('2026-2027',10,'','English'),('2026-2027',10,'','Filipino'),('2026-2027',10,'','MAPEH'),('2026-2027',10,'','Math'),('2026-2027',10,'','Science'),('2026-2027',10,'','TLE'),('2026-2027',10,'','Values Education');
/*!40000 ALTER TABLE `promotion_required_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `removed_mobile_scanners`
--

DROP TABLE IF EXISTS `removed_mobile_scanners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `removed_mobile_scanners` (
  `SCANNER_ID` varchar(60) NOT NULL,
  `SCANNER_NAME` varchar(80) NOT NULL DEFAULT '',
  `REMOVED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`SCANNER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `removed_mobile_scanners`
--

LOCK TABLES `removed_mobile_scanners` WRITE;
/*!40000 ALTER TABLE `removed_mobile_scanners` DISABLE KEYS */;
INSERT INTO `removed_mobile_scanners` VALUES ('001','jj','2026-10-16 12:07:15'),('1','Samsung','2026-10-16 12:04:41');
/*!40000 ALTER TABLE `removed_mobile_scanners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_calendar`
--

DROP TABLE IF EXISTS `school_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_calendar` (
  `CALENDAR_DATE` date NOT NULL,
  `DAY_TYPE` varchar(20) NOT NULL DEFAULT 'school',
  `LABEL` varchar(120) NOT NULL DEFAULT '',
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`CALENDAR_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_calendar`
--

LOCK TABLES `school_calendar` WRITE;
/*!40000 ALTER TABLE `school_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `school_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_year_promotion_plan`
--

DROP TABLE IF EXISTS `school_year_promotion_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_year_promotion_plan` (
  `FROM_GRADE` tinyint(3) unsigned NOT NULL,
  `FROM_STRAND` varchar(20) NOT NULL DEFAULT '',
  `TO_GRADE` tinyint(3) unsigned NOT NULL,
  `TO_STRAND` varchar(20) NOT NULL DEFAULT '',
  `SPLIT_PERCENT` tinyint(3) unsigned NOT NULL DEFAULT 100,
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`FROM_GRADE`,`FROM_STRAND`,`TO_STRAND`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_year_promotion_plan`
--

LOCK TABLES `school_year_promotion_plan` WRITE;
/*!40000 ALTER TABLE `school_year_promotion_plan` DISABLE KEYS */;
INSERT INTO `school_year_promotion_plan` VALUES (7,'',8,'',100,'2026-10-26 06:39:15'),(8,'',9,'',100,'2026-10-26 06:39:15'),(9,'',10,'',100,'2026-10-26 06:39:15'),(10,'',11,'Academic',100,'2026-10-26 06:39:15');
/*!40000 ALTER TABLE `school_year_promotion_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_year_rollover_runs`
--

DROP TABLE IF EXISTS `school_year_rollover_runs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_year_rollover_runs` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `SOURCE_YEAR` varchar(20) NOT NULL,
  `TARGET_YEAR` varchar(20) NOT NULL,
  `PREVIEW_HASH` char(64) NOT NULL,
  `COMPLETED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  `UNDONE_AT` datetime DEFAULT NULL,
  `ACTIVE_SOURCE_YEAR` varchar(20) GENERATED ALWAYS AS (if(`UNDONE_AT` is null,`SOURCE_YEAR`,NULL)) STORED,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uq_completed_source` (`ACTIVE_SOURCE_YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_year_rollover_runs`
--

LOCK TABLES `school_year_rollover_runs` WRITE;
/*!40000 ALTER TABLE `school_year_rollover_runs` DISABLE KEYS */;
/*!40000 ALTER TABLE `school_year_rollover_runs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_year_rollover_sections`
--

DROP TABLE IF EXISTS `school_year_rollover_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_year_rollover_sections` (
  `SCHOOL_YEAR` varchar(20) NOT NULL,
  `SECTION` varchar(80) NOT NULL,
  `GRADE` tinyint(3) unsigned NOT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `RUN_ID` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`SCHOOL_YEAR`,`SECTION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_year_rollover_sections`
--

LOCK TABLES `school_year_rollover_sections` WRITE;
/*!40000 ALTER TABLE `school_year_rollover_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `school_year_rollover_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_year_rollover_students`
--

DROP TABLE IF EXISTS `school_year_rollover_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_year_rollover_students` (
  `RUN_ID` bigint(20) unsigned NOT NULL,
  `STUDENT_ID` varchar(50) NOT NULL,
  `BEFORE_STATE` longtext NOT NULL,
  `AFTER_STATE` longtext NOT NULL,
  `ACADEMIC_STANDING` longtext NOT NULL,
  PRIMARY KEY (`RUN_ID`,`STUDENT_ID`),
  CONSTRAINT `school_year_rollover_students_ibfk_1` FOREIGN KEY (`RUN_ID`) REFERENCES `school_year_rollover_runs` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_year_rollover_students`
--

LOCK TABLES `school_year_rollover_students` WRITE;
/*!40000 ALTER TABLE `school_year_rollover_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `school_year_rollover_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_year_settings`
--

DROP TABLE IF EXISTS `school_year_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_year_settings` (
  `ID` tinyint(3) unsigned NOT NULL,
  `ACTIVE_SCHOOL_YEAR` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_year_settings`
--

LOCK TABLES `school_year_settings` WRITE;
/*!40000 ALTER TABLE `school_year_settings` DISABLE KEYS */;
INSERT INTO `school_year_settings` VALUES (1,'2026-2027');
/*!40000 ALTER TABLE `school_year_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_settings`
--

DROP TABLE IF EXISTS `section_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_settings` (
  `ID` tinyint(3) unsigned NOT NULL,
  `DEFAULT_CAPACITY` smallint(5) unsigned NOT NULL DEFAULT 40,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_settings`
--

LOCK TABLES `section_settings` WRITE;
/*!40000 ALTER TABLE `section_settings` DISABLE KEYS */;
INSERT INTO `section_settings` VALUES (1,40);
/*!40000 ALTER TABLE `section_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `SECTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SECTION` varchar(80) NOT NULL,
  `GRADE` tinyint(3) unsigned DEFAULT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `BASE_SECTION` varchar(80) NOT NULL DEFAULT '',
  `IS_ACTIVE` tinyint(1) NOT NULL DEFAULT 1,
  `CAPACITY` smallint(5) unsigned NOT NULL DEFAULT 40,
  `SORT_ORDER` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`SECTION_ID`),
  UNIQUE KEY `SECTION` (`SECTION`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (3,'Camia',7,'','Camia',1,40,1),(4,'Orchids',7,'','Orchids',1,40,2),(5,'Rose',7,'','Rose',1,40,3),(6,'Jade',8,'','Jade',1,40,6),(7,'Amethyst',8,'','Amethyst',1,40,4),(8,'Emerald',8,'','Emerald',1,40,5),(9,'Peace',9,'','Peace',1,40,7),(10,'Faith',9,'','Faith',1,40,8),(11,'Hope',9,'','Hope',1,40,9),(12,'Aristotle',10,'','Aristotle',1,40,10),(13,'Newton',10,'','Newton',1,40,11),(14,'Einsten',10,'','Einsten',1,40,12),(15,'Kepler',11,'Academic','Kepler',1,40,13),(16,'Smith',11,'Academic','Smith',1,40,14),(17,'Carver',11,'Techpro','Carver',1,40,15),(18,'Prescott',11,'Techpro','Prescott',1,40,16),(19,'Pythagoras',12,'Academic','Pythagoras',1,40,17),(20,'Hilton',12,'Techpro','Hilton',1,40,18),(21,'Burbank',12,'Techpro','Burbank',1,40,19);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_biometrics`
--

DROP TABLE IF EXISTS `staff_biometrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_biometrics` (
  `ROLE` enum('administrator','teacher') NOT NULL,
  `STAFF_ID` int(11) NOT NULL,
  `FACE_PATH` varchar(255) NOT NULL,
  `ENROLLED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ROLE`,`STAFF_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_biometrics`
--

LOCK TABLES `staff_biometrics` WRITE;
/*!40000 ALTER TABLE `staff_biometrics` DISABLE KEYS */;
INSERT INTO `staff_biometrics` VALUES ('administrator',3,'C:\\xampp\\htdocs\\biometric\\storage\\staff-faces\\admin_3.jpg','2026-09-15 21:57:40');
/*!40000 ALTER TABLE `staff_biometrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_face_references`
--

DROP TABLE IF EXISTS `student_face_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_face_references` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STUDENT_ID` int(11) NOT NULL,
  `POSE` enum('front','left','right') NOT NULL,
  `IMAGE_PATH` varchar(255) NOT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `student_pose` (`STUDENT_ID`,`POSE`),
  CONSTRAINT `face_reference_student` FOREIGN KEY (`STUDENT_ID`) REFERENCES `students` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `valid_face_pose` CHECK (`POSE` in ('front','left','right'))
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_face_references`
--

LOCK TABLES `student_face_references` WRITE;
/*!40000 ALTER TABLE `student_face_references` DISABLE KEYS */;
INSERT INTO `student_face_references` VALUES (1,23,'front','uploads/students/123456_Sherly_Concepcion.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(2,25,'front','uploads/students/24356_jovs.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(3,26,'front','uploads/students/2023-02028_Shamil_M._Santiago.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(4,28,'front','uploads/students/2023-00157_Lanie_Rose_S._Elvambuena.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(5,30,'front','uploads/students/2023-01967_Jomarie_O._Fajardo.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(6,31,'front','uploads/students/4941561_Agirs.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(7,37,'front','uploads/students/2023-820056_John_Julius_Concepcion.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(8,38,'front','uploads/students/2023-00228_Benedict_Garis.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(9,39,'front','uploads/students/2026-012345_Marian_Dela_Cruz.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(10,40,'front','uploads/students/2026-123456_Benito.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(11,43,'front','uploads/students/2026-0018_Joven_Diego.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(12,44,'front','uploads/students/2026-0019_Cristalie_Diego.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(13,45,'front','uploads/students/2026-0020_Aries_John_Dela_Cruz.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(14,46,'front','uploads/students/2026-0021_John_harvie_Dela_Cruz.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(15,47,'front','uploads/students/431_Red_Zyricks_miranda.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(16,48,'front','uploads/students/143_juan_Dela_Cruz.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(17,49,'front','uploads/students/456_Albien_Garcia.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(18,50,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(19,51,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(20,52,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(21,53,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(22,54,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(23,55,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(24,56,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(25,57,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(26,58,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(27,59,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(28,60,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(29,61,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(30,62,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(31,63,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(32,64,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(33,65,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(34,66,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(35,67,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(36,68,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(37,69,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(38,70,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(39,71,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(40,72,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(41,73,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(42,74,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(43,75,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(44,76,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(45,77,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(46,78,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(47,79,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(48,80,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(49,81,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(50,82,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(51,83,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(52,84,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(53,85,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(54,86,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(55,87,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(56,88,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(57,89,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(58,90,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(59,91,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(60,92,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(61,93,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(62,94,'front','image/student-preview.png','2026-10-30 04:28:29','2026-10-30 04:28:29'),(63,95,'front','uploads/students/1_Raven__Diego.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(64,96,'front','uploads/students/3132_Lanie_Rose_S_Elvambuena.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29'),(65,97,'front','uploads/students/3133_Mark_Anthony_Arenas_Gioketo.jpg','2026-10-30 04:28:29','2026-10-30 04:28:29');
/*!40000 ALTER TABLE `student_face_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_promotion_decisions`
--

DROP TABLE IF EXISTS `student_promotion_decisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_promotion_decisions` (
  `STUDENT_ID` varchar(50) NOT NULL,
  `SCHOOL_YEAR` varchar(20) NOT NULL,
  `FAILED_SUBJECTS` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `DECISION` varchar(40) NOT NULL,
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`STUDENT_ID`,`SCHOOL_YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_promotion_decisions`
--

LOCK TABLES `student_promotion_decisions` WRITE;
/*!40000 ALTER TABLE `student_promotion_decisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_promotion_decisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_school_history`
--

DROP TABLE IF EXISTS `student_school_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_school_history` (
  `STUDENT_ID` varchar(50) NOT NULL,
  `SCHOOL_YEAR` varchar(20) NOT NULL,
  `GRADE` tinyint(3) unsigned NOT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `SECTION` varchar(80) NOT NULL,
  `ENROLLMENT_STATUS` varchar(20) NOT NULL,
  `ARCHIVED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`STUDENT_ID`,`SCHOOL_YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_school_history`
--

LOCK TABLES `student_school_history` WRITE;
/*!40000 ALTER TABLE `student_school_history` DISABLE KEYS */;
INSERT INTO `student_school_history` VALUES ('105316180002','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105316180002','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105316180002','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105316180002','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105316180002','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105316180006','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105316180006','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105316180006','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105316180006','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105316180006','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105316180007','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105316180007','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105316180007','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105316180007','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105316180007','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105316180014','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105316180014','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105316180014','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105316180014','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105316180014','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105316180029','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105316180029','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105316180029','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105316180029','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105316180029','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105316180049','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105316180049','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105316180049','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105316180049','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105316180049','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105316180054','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105316180054','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105316180054','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105316180054','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105316180054','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105316180061','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105316180061','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105316180061','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105316180061','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105316180061','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105317180006','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105317180006','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105317180006','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105317180006','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105317180006','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105317180011','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105317180011','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105317180011','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105317180011','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105317180011','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105317180012','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105317180012','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105317180012','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105317180012','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105317180012','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105321180009','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105321180009','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105321180009','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105321180009','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105321180009','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180001','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180001','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180001','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180001','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180001','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180003','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180003','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180003','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180003','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180003','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180005','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180005','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180005','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180005','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180005','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180006','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180006','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180006','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180006','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180006','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180012','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180012','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180012','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180012','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180012','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180013','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180013','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180013','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180013','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180013','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180019','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180019','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180019','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180019','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180019','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180020','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180020','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180020','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180020','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180020','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180036','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180036','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180036','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180036','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180036','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180037','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180037','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180037','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180037','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180037','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180038','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180038','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180038','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180038','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180038','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105329180039','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105329180039','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105329180039','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105329180039','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105329180039','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105331170012','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105331170012','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105331170012','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105331170012','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105331170012','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105331180001','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105331180001','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105331180001','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105331180001','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105331180001','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105331180009','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105331180009','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105331180009','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105331180010','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105331180010','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105331180010','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105331180010','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105331180010','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105339180135','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105339180135','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105339180135','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105339180135','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105339180135','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105610180011','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105610180011','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105610180011','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105610180011','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105610180011','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('105616180028','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('105616180028','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('105616180028','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('105616180028','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('105616180028','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('107106180010','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('107106180010','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('107106180010','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('107106180010','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('107106180010','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('108159180481','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('108159180481','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('108159180481','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('108159180481','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('108159180481','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('108781170042','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('108781170042','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('108781170042','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('108781170042','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('108781170042','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('108787150420','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('108787150420','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('108787150420','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('108787150420','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('108787150420','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('109112180113','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('109112180113','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('109112180113','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('109112180113','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('109112180113','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('112752170001','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('112752170001','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('112752170001','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('112752170001','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('112752170001','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('123456','2026-2027',7,'','Camia','Enrolled','2026-10-15 06:54:32'),('123456','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('123456','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('123456','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('123456','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('136736180318','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('136736180318','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('136736180318','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('136736180318','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('136736180318','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('143','2026-2027',9,'','Hope','Enrolled','2026-10-15 06:54:32'),('143','2027-2028',10,'','Einsten','Enrolled','2026-10-15 06:56:07'),('143','2028-2029',11,'Techpro','Carver','Enrolled','2026-10-15 06:56:37'),('143','2031-2032',12,'Techpro','Burbank','Enrolled','2026-10-16 12:15:13'),('158529180003','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('158529180003','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('158529180003','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('158529180003','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('158529180003','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('191509180002','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('191509180002','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('191509180002','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('191509180002','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('191509180002','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('2023-00228','2026-2027',7,'','Camia','Enrolled','2026-10-15 06:54:32'),('2023-00228','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('2023-00228','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('2023-00228','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('2023-00228','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('2023-02028','2026-2027',7,'','Camia','Enrolled','2026-10-15 06:54:32'),('2023-02028','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('2023-02028','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('2023-02028','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('2023-02028','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('2023-820056','2026-2027',7,'','Camia','Enrolled','2026-10-15 06:54:32'),('2023-820056','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('2023-820056','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('2023-820056','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('2023-820056','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('2026-0018','2026-2027',8,'','Jade','Enrolled','2026-10-15 06:54:32'),('2026-0018','2027-2028',11,'Techpro','Prescott','Enrolled','2026-10-15 06:56:07'),('2026-0018','2031-2032',12,'Techpro','Hilton','Enrolled','2026-10-16 12:15:13'),('2026-0020','2026-2027',9,'','Peace','Enrolled','2026-10-15 06:54:32'),('2026-0020','2027-2028',11,'Techpro','Prescott','Enrolled','2026-10-15 06:56:07'),('2026-0020','2031-2032',12,'Techpro','Hilton','Enrolled','2026-10-16 12:15:13'),('2026-0021','2026-2027',12,'Academic','Pythagoras','Enrolled','2026-10-15 06:54:32'),('2026-0021','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('2026-012345','2026-2027',7,'','Camia','Enrolled','2026-10-15 06:54:32'),('2026-012345','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('2026-012345','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('2026-012345','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('2026-012345','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('2026-123456','2026-2027',7,'','Camia','Enrolled','2026-10-15 06:54:32'),('2026-123456','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('2026-123456','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('2026-123456','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('2026-123456','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('229001180001','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('229001180001','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('229001180001','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('229001180001','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('229001180001','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('229001180004','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('229001180004','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('229001180004','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('229001180004','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('229001180004','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('229001180011','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('229001180011','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('229001180011','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('229001180011','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('229001180011','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('24356','2026-2027',7,'','Camia','Enrolled','2026-10-15 06:54:32'),('24356','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('24356','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('24356','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('24356','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('3132','2026-2027',12,'Techpro','Burbank','Enrolled','2026-10-15 06:54:32'),('3132','2031-2032',12,'Techpro','Burbank','Enrolled','2026-10-16 12:15:13'),('3133','2030-2031',7,'','Camia','Enrolled','2026-10-15 07:09:05'),('3133','2031-2032',8,'','Amethyst','Enrolled','2026-10-16 12:15:13'),('431','2026-2027',10,'','Newton','Enrolled','2026-10-15 06:54:32'),('431','2027-2028',11,'Techpro','Prescott','Enrolled','2026-10-15 06:56:07'),('431','2031-2032',12,'Techpro','Hilton','Enrolled','2026-10-16 12:15:13'),('456','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('456','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('456','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('456','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('456','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('500332170163','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('500332170163','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('500332170163','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('500332170163','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('500332170163','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13'),('500728170056','2026-2027',8,'','Amethyst','Enrolled','2026-10-15 06:54:32'),('500728170056','2027-2028',9,'','Faith','Enrolled','2026-10-15 06:56:07'),('500728170056','2028-2029',10,'','Aristotle','Enrolled','2026-10-15 06:56:37'),('500728170056','2029-2030',11,'Academic','Kepler','Enrolled','2026-10-15 07:02:55'),('500728170056','2031-2032',12,'Academic','Pythagoras','Enrolled','2026-10-16 12:15:13');
/*!40000 ALTER TABLE `student_school_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_subject_results`
--

DROP TABLE IF EXISTS `student_subject_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_subject_results` (
  `STUDENT_ID` varchar(50) NOT NULL,
  `SCHOOL_YEAR` varchar(20) NOT NULL,
  `SUBJECT` varchar(80) NOT NULL,
  `RESULT` varchar(10) NOT NULL,
  `TEACHER_ID` int(11) NOT NULL,
  `GRADE` tinyint(3) unsigned NOT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `SECTION` varchar(80) NOT NULL,
  `FINAL_GRADE` decimal(5,2) DEFAULT NULL,
  `Q4_GRADE` decimal(5,2) DEFAULT NULL,
  `Q3_GRADE` decimal(5,2) DEFAULT NULL,
  `Q2_GRADE` decimal(5,2) DEFAULT NULL,
  `Q1_GRADE` decimal(5,2) DEFAULT NULL,
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`STUDENT_ID`,`SCHOOL_YEAR`,`SUBJECT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_subject_results`
--

LOCK TABLES `student_subject_results` WRITE;
/*!40000 ALTER TABLE `student_subject_results` DISABLE KEYS */;
INSERT INTO `student_subject_results` VALUES ('191509180002','2026-2027','Filipino','Passed',6,8,'','Amethyst',78.67,NULL,80.00,76.00,80.00,'2026-10-29 09:13:27');
/*!40000 ALTER TABLE `student_subject_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STUDENT_ID` varchar(20) NOT NULL,
  `STUDENT_NAME` varchar(100) NOT NULL,
  `FIRST_NAME` varchar(80) NOT NULL DEFAULT '',
  `MIDDLE_NAME` varchar(80) NOT NULL DEFAULT '',
  `LAST_NAME` varchar(80) NOT NULL DEFAULT '',
  `GRADE` tinyint(3) unsigned DEFAULT NULL,
  `AGE` tinyint(3) unsigned DEFAULT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `ADDRESS` varchar(255) NOT NULL DEFAULT '',
  `IMAGE_PATH` varchar(255) NOT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `SECTION` varchar(80) DEFAULT NULL,
  `ENROLLMENT_STATUS` varchar(20) NOT NULL DEFAULT 'Enrolled',
  `STUDENT_STATUS` varchar(20) NOT NULL DEFAULT 'Active',
  `ARCHIVE_REASON` varchar(40) NOT NULL DEFAULT '',
  `IS_ARCHIVED` tinyint(1) NOT NULL DEFAULT 0,
  `ARCHIVED_AT` datetime DEFAULT NULL,
  `ARCHIVED_BY` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `STUDENT_ID` (`STUDENT_ID`),
  UNIQUE KEY `STUDENT_ID_2` (`STUDENT_ID`),
  UNIQUE KEY `STUDENT_ID_3` (`STUDENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=913 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (23,'123456','Sherly Concepcion','Sherly','','Concepcion',7,NULL,'','','uploads/students/123456_Sherly_Concepcion.jpg','2026-10-26 04:36:32','Camia','Enrolled','Active','',0,NULL,NULL),(25,'24356','jovs','jovs','','jovs',7,NULL,'','','uploads/students/24356_jovs.jpg','2026-10-26 04:36:32','Camia','Enrolled','Active','',0,NULL,NULL),(26,'2023-02028','Shamil M. Santiago','Shamil','','M. Santiago',7,NULL,'','','uploads/students/2023-02028_Shamil_M._Santiago.jpg','2026-10-26 04:36:32','Camia','Enrolled','Active','',0,NULL,NULL),(28,'2023-00157','Lanie S Elvambuena','Lanie','S','Elvambuena',7,21,'','Not provided','uploads/students/2023-00157_Lanie_Rose_S._Elvambuena.jpg','2026-10-31 12:16:23','Camia','Archived','Archived','Graduated',0,'2026-10-31 20:16:23',NULL),(30,'2023-01967','Jomarie O. Fajardo','Jomarie','','O. Fajardo',7,NULL,'','','uploads/students/2023-01967_Jomarie_O._Fajardo.jpg','2026-10-31 12:16:23','Camia','Archived','Archived','Graduated',0,'2026-10-31 20:16:23',NULL),(31,'4941561','Agirs Agirs','Agirs','','Agirs',7,NULL,'','','uploads/students/4941561_Agirs.jpg','2026-10-31 12:16:23','Orchids','Archived','Archived','Graduated',0,'2026-10-31 20:16:23',NULL),(37,'2023-820056','John Julius  Concepion','John Julius','','Concepion',7,22,'','Maruhat','uploads/students/2023-820056_John_Julius_Concepcion.jpg','2026-10-26 04:36:32','Camia','Enrolled','Active','',1,NULL,'admin@biometrics.com'),(38,'2023-00228','Benedict Garis','Benedict','','Garis',7,NULL,'','','uploads/students/2023-00228_Benedict_Garis.jpg','2026-10-26 04:36:32','Camia','Enrolled','Active','',0,NULL,NULL),(39,'2026-012345','Marian Dela Cruz','Marian','','Dela Cruz',7,NULL,'','','uploads/students/2026-012345_Marian_Dela_Cruz.jpg','2026-10-26 04:36:32','Camia','Enrolled','Active','',0,NULL,NULL),(40,'2026-123456','Benito','Benito','','Benito',7,NULL,'','','uploads/students/2026-123456_Benito.jpg','2026-10-26 04:36:32','Camia','Enrolled','Active','',0,NULL,NULL),(43,'2026-0018','Joven Diego','Joven','','Diego',8,NULL,'','','uploads/students/2026-0018_Joven_Diego.jpg','2026-10-26 04:36:32','Jade','Enrolled','Active','',0,NULL,NULL),(44,'2026-0019','Cristalie Diego','Cristalie','','Diego',11,NULL,'Academic','','uploads/students/2026-0019_Cristalie_Diego.jpg','2026-10-31 12:16:23','Kepler','Archived','Archived','Graduated',0,'2026-10-31 20:16:23',NULL),(45,'2026-0020','Aries John Dela Cruz','Aries John','','Dela Cruz',9,22,'','Mahipon','uploads/students/2026-0020_Aries_John_Dela_Cruz.jpg','2026-10-26 04:36:32','Peace','Enrolled','Active','',0,NULL,NULL),(46,'2026-0021','John harvie Dela Cruz','John harvie','','Dela Cruz',12,17,'Academic','Maruhat','uploads/students/2026-0021_John_harvie_Dela_Cruz.jpg','2026-10-17 11:21:42','Pythagoras','Enrolled','Active','',0,NULL,NULL),(47,'431','Red Zyricks miranda','Red Zyricks','','miranda',10,15,'','Maruhat','uploads/students/431_Red_Zyricks_miranda.jpg','2026-10-26 04:36:32','Newton','Enrolled','Active','',0,NULL,NULL),(48,'143','juan Dela Cruz','juan','','Dela Cruz',9,21,'','Mahipon','uploads/students/143_juan_Dela_Cruz.jpg','2026-10-26 04:36:32','Hope','Enrolled','Active','',0,NULL,NULL),(49,'456','Albien Garcia','Albien','','Garcia',8,13,'','Maruhat','uploads/students/456_Albien_Garcia.jpg','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(50,'191509180002','JOHN ABROGAR ACALA','JOHN','ABROGAR','ACALA',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(51,'105331180009','REYGIN VILLACAMPA ALDE','REYGIN','VILLACAMPA','ALDE',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(52,'105316180002','HARVEY OMOLIDA BATUNGBAKAL','HARVEY','OMOLIDA','BATUNGBAKAL',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(53,'108781170042','HANNAH GRACE TIUSECO ALVAREZ','HANNAH GRACE','TIUSECO','ALVAREZ',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(54,'229001180011','JAMES PADAYAO CASTRO','JAMES','PADAYAO','CASTRO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(55,'108787150420','JULIANA TIUSECO ALVAREZ','JULIANA','TIUSECO','ALVAREZ',8,16,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(56,'105339180135','JIRO AEON UVAS DELA CRUZ','JIRO AEON','UVAS','DELA CRUZ',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(57,'105616180028','RACHELLE DE JESUS AVES','RACHELLE','DE JESUS','AVES',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(58,'105329180005','JHONNY VENDIVEL DELA PEÑA','JHONNY','VENDIVEL','DELA PEÑA',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(59,'105331180010','CLOUIE JANE OLITE BALDUISA','CLOUIE JANE','OLITE','BALDUISA',8,12,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(60,'105317180006','JUZTINE AEXIS YUZON FRANCISCO','JUZTINE AEXIS','YUZON','FRANCISCO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(61,'105321180009','ALAIZZA CASTRO CAO','ALAIZZA','CASTRO','CAO',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(62,'105329180003','ALBIEN MCLLOYD SIMBULAN GARCIA','ALBIEN MCLLOYD','SIMBULAN','GARCIA',8,12,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(63,'105316180061','JOBYLYN GUERRERO CARAAT','JOBYLYN','GUERRERO','CARAAT',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(64,'105331180001','HERO CANUBAS GARCIA','HERO','CANUBAS','GARCIA',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(65,'229001180001','JHANINE HERNANDEZ CASTILLO','JHANINE','HERNANDEZ','CASTILLO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(66,'105329180001','KEN CYRUS FACTOR GARCIA','KEN CYRUS','FACTOR','GARCIA',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(67,'158529180003','HANNA RAZON DE GUZMAN','HANNA','RAZON','DE GUZMAN',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(68,'105329180006','EDGAR JAMES VENDIVEL LEGASPI','EDGAR JAMES','VENDIVEL','LEGASPI',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(69,'105329180012','ALEXA ESTUISTA DE JESUS','ALEXA','ESTUISTA','DE JESUS',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(70,'107106180010','JARRED CARL MICUA MARCELO','JARRED CARL','MICUA','MARCELO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(71,'105316180049','RICALYN SANCHEZ DELOS SANTOS','RICALYN','SANCHEZ','DELOS SANTOS',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(72,'105316180006','RHANE DELA CRUZ MENDOZA','RHANE','DELA CRUZ','MENDOZA',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(73,'105329180013','WINCESS RHIANA MANUEL EVANGELISTA','WINCESS RHIANA','MANUEL','EVANGELISTA',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(74,'105317180011','CHRISTIAN VHER LIGGAYU NERI','CHRISTIAN VHER','LIGGAYU','NERI',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(75,'105329180020','JULIENNE CHANDRIA GARDOCE GACO','JULIENNE CHANDRIA','GARDOCE','GACO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(76,'105316180007','ANDREW VELAYO ORERA','ANDREW','VELAYO','ORERA',8,12,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(77,'229001180004','PRINCESS NICA MINSIDOR HERNANDEZ','PRINCESS NICA','MINSIDOR','HERNANDEZ',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(78,'105331170012','RAIN JASTER DE LEON RUDIO','RAIN JASTER','DE LEON','RUDIO',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(79,'105316180029','KYLIE ANNE MULA MATEO','KYLIE ANNE','MULA','MATEO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(80,'105317180012','JOSH NATHAN BATAC SIMBULAN','JOSH NATHAN','BATAC','SIMBULAN',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(81,'105316180054','EUNICE DELOS REYES MELINDO','EUNICE','DELOS REYES','MELINDO',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(82,'105316180014','JARRED ENRIQUEZ TULIO','JARRED','ENRIQUEZ','TULIO',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(83,'108159180481','ISABEL JANE RAYTON OBSIANA','ISABEL JANE','RAYTON','OBSIANA',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(84,'500332170163','MARTINA BERNADETTE REMOLACIO ORSOS','MARTINA BERNADETTE','REMOLACIO','ORSOS',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(85,'500728170056','RHIAN SAN DIEGO PAGBA','RHIAN','SAN DIEGO','PAGBA',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(86,'136736180318','LOUISE RAPHAEL GACO RAMILO','LOUISE RAPHAEL','GACO','RAMILO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(87,'112752170001','ERICKA MAE TIMBAL RODRIGUEZ','ERICKA MAE','TIMBAL','RODRIGUEZ',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(88,'105610180011','JEWEL MONTOYA RUDIO','JEWEL','MONTOYA','RUDIO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(89,'109112180113','JERRYMAE LORENZANA SABALLO','JERRYMAE','LORENZANA','SABALLO',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(90,'105329180036','ANGEL ANN BERNABE TINIO','ANGEL ANN','BERNABE','TINIO',8,12,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(91,'105329180037','KHIM VIADOR VELAYO','KHIM','VIADOR','VELAYO',8,15,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(92,'105329180038','SHANTAL JADE TOMAS VENDIVEL','SHANTAL JADE','TOMAS','VENDIVEL',8,14,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(93,'105329180019','PAULA ANDREA VELAYO VENDIVEL','PAULA ANDREA','VELAYO','VENDIVEL',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(94,'105329180039','ANNE TRIXIE RUDIO VITUALLA','ANNE TRIXIE','RUDIO','VITUALLA',8,13,'','Not provided','image/student-preview.png','2026-10-26 04:36:32','Amethyst','Enrolled','Active','',0,NULL,NULL),(95,'1','Raven  Diego','Raven','','Diego',8,19,'','Not provided','uploads/students/1_Raven__Diego.jpg','2026-10-31 12:16:23','Jade','Archived','Archived','Graduated',0,'2026-10-31 20:16:23',NULL),(96,'3132','Lanie Rose S Elvambuena','Lanie Rose','S','Elvambuena',12,21,'Techpro','Not provided','uploads/students/3132_Lanie_Rose_S_Elvambuena.jpg','2026-10-17 11:21:42','Burbank','Enrolled','Active','',0,NULL,NULL),(97,'3133','Mark Anthony Arenas Gioketo','Mark Anthony','Arenas','Gioketo',7,13,'','Maruhat','uploads/students/3133_Mark_Anthony_Arenas_Gioketo.jpg','2026-10-17 11:21:42','Camia','Enrolled','Active','',0,NULL,NULL);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_advisory_assignments`
--

DROP TABLE IF EXISTS `teacher_advisory_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_advisory_assignments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEACHER_ID` int(11) NOT NULL,
  `SECTION_ID` int(11) NOT NULL,
  `SCHOOL_YEAR` varchar(20) NOT NULL,
  `RELEASED_AT` datetime DEFAULT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  `ACTIVE_TEACHER_ID` int(11) GENERATED ALWAYS AS (if(`RELEASED_AT` is null,`TEACHER_ID`,NULL)) STORED,
  `ACTIVE_SECTION_ID` int(11) GENERATED ALWAYS AS (if(`RELEASED_AT` is null,`SECTION_ID`,NULL)) STORED,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uq_adviser_year` (`SCHOOL_YEAR`,`ACTIVE_TEACHER_ID`),
  UNIQUE KEY `uq_section_year` (`SCHOOL_YEAR`,`ACTIVE_SECTION_ID`),
  KEY `TEACHER_ID` (`TEACHER_ID`),
  KEY `SECTION_ID` (`SECTION_ID`),
  CONSTRAINT `teacher_advisory_assignments_ibfk_1` FOREIGN KEY (`TEACHER_ID`) REFERENCES `teachers` (`TEACHER_ID`),
  CONSTRAINT `teacher_advisory_assignments_ibfk_2` FOREIGN KEY (`SECTION_ID`) REFERENCES `sections` (`SECTION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_advisory_assignments`
--

LOCK TABLES `teacher_advisory_assignments` WRITE;
/*!40000 ALTER TABLE `teacher_advisory_assignments` DISABLE KEYS */;
INSERT INTO `teacher_advisory_assignments` VALUES (1,6,7,'2026-2027',NULL,'2026-10-28 13:50:53',6,7),(2,7,3,'2026-2027',NULL,'2026-10-28 13:50:54',7,3),(3,8,4,'2026-2027',NULL,'2026-10-28 13:50:54',8,4),(4,9,5,'2026-2027',NULL,'2026-10-28 13:50:54',9,5),(5,10,8,'2026-2027',NULL,'2026-10-28 13:50:55',10,8),(6,11,6,'2026-2027',NULL,'2026-10-28 13:50:55',11,6),(7,12,9,'2026-2027',NULL,'2026-10-28 13:50:55',12,9),(8,13,10,'2026-2027',NULL,'2026-10-28 13:50:55',13,10),(9,14,11,'2026-2027',NULL,'2026-10-28 13:50:56',14,11),(10,15,12,'2026-2027',NULL,'2026-10-28 13:50:56',15,12),(11,16,13,'2026-2027',NULL,'2026-10-28 13:50:56',16,13),(12,17,14,'2026-2027',NULL,'2026-10-28 13:50:57',17,14),(13,18,15,'2026-2027',NULL,'2026-10-28 13:50:57',18,15),(14,19,16,'2026-2027',NULL,'2026-10-28 13:50:57',19,16),(15,20,17,'2026-2027',NULL,'2026-10-28 13:50:57',20,17),(16,21,18,'2026-2027',NULL,'2026-10-28 13:50:58',21,18),(17,22,19,'2026-2027',NULL,'2026-10-28 13:50:58',22,19),(18,23,20,'2026-2027',NULL,'2026-10-28 13:50:58',23,20),(19,24,21,'2026-2027',NULL,'2026-10-28 13:50:59',24,21);
/*!40000 ALTER TABLE `teacher_advisory_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_assignments`
--

DROP TABLE IF EXISTS `teacher_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_assignments` (
  `TEACHER_ID` int(11) NOT NULL,
  `GRADE` tinyint(3) unsigned NOT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `SECTION` varchar(80) NOT NULL,
  `SUBJECT` varchar(80) NOT NULL DEFAULT '',
  `SCHOOL_YEAR` varchar(20) NOT NULL,
  PRIMARY KEY (`TEACHER_ID`,`SCHOOL_YEAR`,`GRADE`,`STRAND`,`SECTION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_assignments`
--

LOCK TABLES `teacher_assignments` WRITE;
/*!40000 ALTER TABLE `teacher_assignments` DISABLE KEYS */;
INSERT INTO `teacher_assignments` VALUES (5,7,'','Camia','English','2026-2027'),(5,8,'','Jade','Araling Panlipunan','2026-2027'),(6,8,'','Amethyst','Filipino','2026-2027');
/*!40000 ALTER TABLE `teacher_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers` (
  `TEACHER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEACHER_USER` varchar(100) NOT NULL,
  `TEACHER_PASS` varchar(255) NOT NULL,
  `TEACHER_NAME` varchar(120) NOT NULL,
  `FIRST_NAME` varchar(80) NOT NULL DEFAULT '',
  `LAST_NAME` varchar(80) NOT NULL DEFAULT '',
  `GRADE` tinyint(3) unsigned DEFAULT NULL,
  `STRAND` varchar(20) NOT NULL DEFAULT '',
  `SECTION` varchar(80) NOT NULL DEFAULT '',
  `SUBJECT` varchar(80) DEFAULT NULL,
  `TEACHER_STATUS` varchar(20) NOT NULL DEFAULT 'Active',
  `ARCHIVED_AT` datetime DEFAULT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp(),
  `MUST_CHANGE_PASSWORD` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`TEACHER_ID`),
  UNIQUE KEY `uq_teacher_user` (`TEACHER_USER`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (5,'julius@gmail.com','$2y$10$BsJsArF/AMI82vyslf0N4Oy9vlXEOxxFRJjQHE3/bOlUZjwmbcHfG','julius concepcion','julius','concepcion',7,'','Camia','English','Archived','2026-10-13 07:22:48','2026-09-09 05:05:22',0),(6,'hazel@biometrics.com','$2y$10$jdsc9WIVE/XoG53wJt0PZ.ssSK/BTot0GzY7WyM4GBN7FybqwpwP.','Hazel Charise Leoncio','Hazel Charise','Leoncio',8,'','Amethyst','Filipino','Active',NULL,'2026-09-23 15:02:56',0),(7,'maria.cristina.santos@teachers.maruhat.example','$2y$10$L27rR6ZU0TClMvhPDKV/ZOUWjTXz9pWiuvPh1dBRj8tIyHOHDXY62','Maria Cristina Santos','Maria Cristina','Santos',7,'','Camia','','Active',NULL,'2026-10-28 13:50:54',1),(8,'jose.miguel.reyes@teachers.maruhat.example','$2y$10$UHR2gs/dQUqD7N4ewjwLGutDe7Tzf1EY6VUBgYuNnXE7HrJLnMkQ.','Jose Miguel Reyes','Jose Miguel','Reyes',7,'','Orchids','','Active',NULL,'2026-10-28 13:50:54',1),(9,'angela.mae.cruz@teachers.maruhat.example','$2y$10$noSPAlxDz3C.UgBcvOIWxOx/aUhCiLwRO8ssrmqJyrKot6et6pgWW','Angela Mae Cruz','Angela Mae','Cruz',7,'','Rose','','Active',NULL,'2026-10-28 13:50:54',1),(10,'patricia.anne.mendoza@teachers.maruhat.example','$2y$10$DsvEXOi2m4ipcfTia5C2h.MD30gtYpB85a4XcI0KiR0jfQqYJYKUu','Patricia Anne Mendoza','Patricia Anne','Mendoza',8,'','Emerald','','Active',NULL,'2026-10-28 13:50:55',1),(11,'rafael.luis.garcia@teachers.maruhat.example','$2y$10$e0Dc5AkbkIsxYQh3v/kNHeVrvSFAmZNcZk4NkXBpZaLWMad0J/I5S','Rafael Luis Garcia','Rafael Luis','Garcia',8,'','Jade','','Active',NULL,'2026-10-28 13:50:55',1),(12,'camille.rose.bautista@teachers.maruhat.example','$2y$10$WpCVpPT25DtYEQo0KMAGtuqpWP2W5PEdKTiDaqXYryPXcVmjwa0la','Camille Rose Bautista','Camille Rose','Bautista',9,'','Peace','','Active',NULL,'2026-10-28 13:50:55',1),(13,'daniel.joseph.ramos@teachers.maruhat.example','$2y$10$RVLNOxdxMsfj8uMNjGYhbuRueOSgiANWxyB0Wy5xQEsaXBjfMDpzS','Daniel Joseph Ramos','Daniel Joseph','Ramos',9,'','Faith','','Active',NULL,'2026-10-28 13:50:55',1),(14,'kristine.joy.aquino@teachers.maruhat.example','$2y$10$f8LcoUBbrsJFlA2bEqXyReSMGMbpFZhVcjEPJ9sKKNYeM9QYi7s8S','Kristine Joy Aquino','Kristine Joy','Aquino',9,'','Hope','','Active',NULL,'2026-10-28 13:50:56',1),(15,'mark.anthony.villanueva@teachers.maruhat.example','$2y$10$p3yohLuuaUN42aFgdbBbAe9kBt3pz3zfHYXzkkJBIQIxmoBcf/wQC','Mark Anthony Villanueva','Mark Anthony','Villanueva',10,'','Aristotle','','Active',NULL,'2026-10-28 13:50:56',1),(16,'andrea.nicole.navarro@teachers.maruhat.example','$2y$10$juShVBafyGnzrbEyJTr7Hep5Buz.1/d1KM7z.19zZKTSOnr4LRnBS','Andrea Nicole Navarro','Andrea Nicole','Navarro',10,'','Newton','','Active',NULL,'2026-10-28 13:50:56',1),(17,'paolo.gabriel.castillo@teachers.maruhat.example','$2y$10$ixtoXi9VQEs1SH864o2fouVz2jlxuRbJa63A/EaLmEgQ0of8ryX8K','Paolo Gabriel Castillo','Paolo Gabriel','Castillo',10,'','Einsten','','Active',NULL,'2026-10-28 13:50:57',1),(18,'isabella.marie.torres@teachers.maruhat.example','$2y$10$JqTq8gouZzLuacsoITm59ugTalWtzgix.hNvMKcMpmlofB8BPPPr6','Isabella Marie Torres','Isabella Marie','Torres',11,'Academic','Kepler','','Active',NULL,'2026-10-28 13:50:57',1),(19,'vincent.carlo.dela.cruz@teachers.maruhat.example','$2y$10$1yd6Nq/.rkFmEhFbV.7c.eU/SUvR.9u4siOltXu02X81cl1LVyYU2','Vincent Carlo Dela Cruz','Vincent Carlo','Dela Cruz',11,'Academic','Smith','','Active',NULL,'2026-10-28 13:50:57',1),(20,'alyssa.grace.fernandez@teachers.maruhat.example','$2y$10$u1BQdg1O72WLZiNM9/GVAOjzcHBkAupzskq2kgjW6LRK3Nt9bkPgi','Alyssa Grace Fernandez','Alyssa Grace','Fernandez',11,'Techpro','Carver','','Active',NULL,'2026-10-28 13:50:57',1),(21,'nathaniel.james.soriano@teachers.maruhat.example','$2y$10$pN6hr2zESloT.tkNbdFYaudEg8GPamn0VCqjZvfTciX9He2awFA0C','Nathaniel James Soriano','Nathaniel James','Soriano',11,'Techpro','Prescott','','Active',NULL,'2026-10-28 13:50:58',1),(22,'beatrice.anne.mercado@teachers.maruhat.example','$2y$10$X0oKxwc/jRrov.vyf6TGq.yyw3NrVhPXfsCMviA/8qDWi8NKvDIxO','Beatrice Anne Mercado','Beatrice Anne','Mercado',12,'Academic','Pythagoras','','Active',NULL,'2026-10-28 13:50:58',1),(23,'adrian.rafael.domingo@teachers.maruhat.example','$2y$10$em.K2kp1JVWfBacOHnkj9uAELSUynx6AyRIKGxk7E8KcBs5XJRNNi','Adrian Rafael Domingo','Adrian Rafael','Domingo',12,'Techpro','Hilton','','Active',NULL,'2026-10-28 13:50:58',1),(24,'sofia.camille.velasco@teachers.maruhat.example','$2y$10$Kb7Y2uqH8XeGjDExqMTqpemPCN/HPwiWiU4i8qIr1bmpXWiry3tuy','Sofia Camille Velasco','Sofia Camille','Velasco',12,'Techpro','Burbank','','Active',NULL,'2026-10-28 13:50:59',1);
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'biometric'
--

--
-- Dumping routines for database 'biometric'
--

--
-- Current Database: `biometric`
--

USE `biometric`;

--
-- Final view structure for view `current_teacher_advisory_assignments`
--

/*!50001 DROP VIEW IF EXISTS `current_teacher_advisory_assignments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_teacher_advisory_assignments` AS select `a`.`TEACHER_ID` AS `TEACHER_ID`,`a`.`SCHOOL_YEAR` AS `SCHOOL_YEAR`,`s`.`SECTION_ID` AS `SECTION_ID`,`s`.`GRADE` AS `GRADE`,`s`.`STRAND` AS `STRAND`,`s`.`SECTION` AS `SECTION` from (((`teacher_advisory_assignments` `a` join `sections` `s` on(`s`.`SECTION_ID` = `a`.`SECTION_ID` and `s`.`IS_ACTIVE` = 1)) join `school_year_settings` `sy` on(`sy`.`ID` = 1 and `sy`.`ACTIVE_SCHOOL_YEAR` = `a`.`SCHOOL_YEAR`)) join `teachers` `t` on(`t`.`TEACHER_ID` = `a`.`TEACHER_ID` and `t`.`TEACHER_STATUS` = 'Active')) where `a`.`RELEASED_AT` is null */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `current_teacher_subject_assignments`
--

/*!50001 DROP VIEW IF EXISTS `current_teacher_subject_assignments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_teacher_subject_assignments` AS select `ta`.`TEACHER_ID` AS `TEACHER_ID`,`ta`.`GRADE` AS `GRADE`,`ta`.`STRAND` AS `STRAND`,`ta`.`SECTION` AS `SECTION`,`ta`.`SUBJECT` AS `SUBJECT`,`ta`.`SCHOOL_YEAR` AS `SCHOOL_YEAR` from ((`teacher_assignments` `ta` join `school_year_settings` `sy` on(`sy`.`ID` = 1 and `sy`.`ACTIVE_SCHOOL_YEAR` = `ta`.`SCHOOL_YEAR`)) join `teachers` `t` on(`t`.`TEACHER_ID` = `ta`.`TEACHER_ID` and `t`.`TEACHER_STATUS` = 'Active')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-03 17:55:40
