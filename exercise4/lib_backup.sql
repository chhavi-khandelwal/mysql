-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Branch`
--

DROP TABLE IF EXISTS `Branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Branch` (
  `BCode` varchar(20) NOT NULL,
  `Librarian` varchar(20) NOT NULL,
  `Holdings` varchar(30) NOT NULL,
  PRIMARY KEY (`BCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Branch`
--

LOCK TABLES `Branch` WRITE;
/*!40000 ALTER TABLE `Branch` DISABLE KEYS */;
INSERT INTO `Branch` VALUES ('B1','John Smith','2 Anglesea Rd'),('B2','Mary Jones','34 Pearse St'),('B3','Francis Owens','Grange X');
/*!40000 ALTER TABLE `Branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Holdings`
--

DROP TABLE IF EXISTS `Holdings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Holdings` (
  `branch` varchar(4) NOT NULL DEFAULT '',
  `Title` varchar(20) NOT NULL DEFAULT '',
  `#copies` tinyint(4) NOT NULL,
  PRIMARY KEY (`branch`,`Title`),
  KEY `Title` (`Title`),
  CONSTRAINT `Holdings_ibfk_1` FOREIGN KEY (`branch`) REFERENCES `Branch` (`BCode`),
  CONSTRAINT `Holdings_ibfk_2` FOREIGN KEY (`Title`) REFERENCES `Titles` (`Title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Holdings`
--

LOCK TABLES `Holdings` WRITE;
/*!40000 ALTER TABLE `Holdings` DISABLE KEYS */;
INSERT INTO `Holdings` VALUES ('B1','A History of Dublin',1),('B1','How to Fish',2),('B1','Susannah',3),('B2','Computers',2),('B2','How to Fish',4),('B2','The Wife',3),('B3','A History Of Dublin',1),('B3','Computers',4),('B3','Susannah',3),('B3','The Wife',1);
/*!40000 ALTER TABLE `Holdings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Titles`
--

DROP TABLE IF EXISTS `Titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Titles` (
  `Title` varchar(20) NOT NULL,
  `Author` varchar(20) NOT NULL,
  `Publisher` varchar(20) NOT NULL,
  PRIMARY KEY (`Title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Titles`
--

LOCK TABLES `Titles` WRITE;
/*!40000 ALTER TABLE `Titles` DISABLE KEYS */;
INSERT INTO `Titles` VALUES ('A History of Dublin','David Little','Wiley'),('Computers','Blaise Pascal','Applewoods'),('How to Fish','Amy Fly','Stop Press'),('Susannah','Ann Brown','Macmillan'),('The Wife','Ann Brown','Macmillan');
/*!40000 ALTER TABLE `Titles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-11-13 11:50:50
