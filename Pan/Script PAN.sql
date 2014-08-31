-- MySQL dump 10.11
--
-- Host: localhost    Database: PAN
-- ------------------------------------------------------
-- Server version	5.0.51a-community-nt

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
-- Table structure for table `classerisco`
--

DROP TABLE IF EXISTS `classerisco`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `classerisco` (
  `IDCLASSERISCO` int(10) NOT NULL auto_increment,
  `CLASSE` char(5) character set latin1 default NULL,
  PRIMARY KEY  (`IDCLASSERISCO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `classerisco`
--

LOCK TABLES `classerisco` WRITE;
/*!40000 ALTER TABLE `classerisco` DISABLE KEYS */;
/*!40000 ALTER TABLE `classerisco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cliente` (
  `IDCLIENTE` smallint(5) unsigned NOT NULL auto_increment,
  `NOMECLIENTE` varchar(50) default NULL,
  `CODIGO` char(10) character set latin1 default NULL,
  PRIMARY KEY  (`IDCLIENTE`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `produto` (
  `IDPRODUTO` int(10) unsigned NOT NULL auto_increment,
  `CODIGO` char(10) character set latin1 default NULL,
  `NOMEPRODUTO` varchar(200) default NULL,
  `UNIDADE` varchar(10) default NULL,
  `NUMONU` int(11) default NULL,
  `DIASVALIDADE` int(11) default NULL,
  PRIMARY KEY  (`IDPRODUTO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saida`
--

DROP TABLE IF EXISTS `saida`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `saida` (
  `IDSAIDA` int(10) unsigned NOT NULL auto_increment,
  `DATA` date NOT NULL,
  `HORA` time NOT NULL,
  `LOTE` char(20) character set latin1 default NULL,
  `PESOLIQUIDO` float(15,6) default NULL,
  `PESOBRUTO` float(15,6) default NULL,
  `FABRICACAO` date default NULL,
  `VALIDADE` date default NULL,
  `NUMONU` int(11) default NULL,
  `IDCLIENTE` int(11) NOT NULL,
  `IDPRODUTO` int(11) NOT NULL,
  `IDCLASSERISCO` int(11) default NULL,
  `IDTEXTOS` int(11) default NULL,
  `TITULO1` varchar(30) default NULL,
  `TEXTO1` text character set latin1,
  `TITULO2` varchar(30) default NULL,
  `TEXTO2` text character set latin1,
  `TITULO3` varchar(30) default NULL,
  `TEXTO3` text character set latin1,
  `TITULO4` varchar(30) default NULL,
  `TEXTO4` text character set latin1,
  `TITULO5` varchar(30) default NULL,
  `TEXTO5` text character set latin1,
  `TITULO6` varchar(30) default NULL,
  `TEXTO6` text character set latin1,
  PRIMARY KEY  (`IDSAIDA`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `saida`
--

LOCK TABLES `saida` WRITE;
/*!40000 ALTER TABLE `saida` DISABLE KEYS */;
/*!40000 ALTER TABLE `saida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `textos`
--

DROP TABLE IF EXISTS `textos`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `textos` (
  `IDTEXTOS` int(11) NOT NULL auto_increment,
  `CODIGO` varchar(10) default NULL,
  `DESCRICAO` varchar(40) default NULL,
  `TITULO1` varchar(30) default NULL,
  `TEXTO1` text character set latin1,
  `TITULO2` varchar(30) default NULL,
  `TEXTO2` text character set latin1,
  `TITULO3` varchar(30) default NULL,
  `TEXTO3` text character set latin1,
  `TITULO4` varchar(30) default NULL,
  `TEXTO4` text character set latin1,
  `TITULO5` varchar(30) default NULL,
  `TEXTO5` text character set latin1,
  `TITULO6` varchar(30) default NULL,
  `TEXTO6` text character set latin1,
  PRIMARY KEY  (`IDTEXTOS`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `textos`
--

LOCK TABLES `textos` WRITE;
/*!40000 ALTER TABLE `textos` DISABLE KEYS */;
/*!40000 ALTER TABLE `textos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-08-15  1:39:02
