# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.7.17)
# Database: theme_park
# Generation Time: 2017-03-22 23:23:44 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table CUSTOMER
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CUSTOMER`;

CREATE TABLE `CUSTOMER` (
  `Fname` varchar(15) DEFAULT NULL,
  `Lname` varchar(15) DEFAULT NULL,
  `t_id` int(11) DEFAULT NULL,
  KEY `t_id` (`t_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `TICKET` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table DEPARTMENT
# ------------------------------------------------------------

DROP TABLE IF EXISTS `DEPARTMENT`;

CREATE TABLE `DEPARTMENT` (
  `Dname` varchar(15) NOT NULL,
  `Dnumber` int(11) NOT NULL,
  `Mgr_ssn` char(9) NOT NULL,
  `mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`Dnumber`),
  UNIQUE KEY `Dname` (`Dname`),
  KEY `Mgr_ssn` (`Mgr_ssn`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`Mgr_ssn`) REFERENCES `EMPLOYEE` (`Ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table EMPLOYEE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `EMPLOYEE`;

CREATE TABLE `EMPLOYEE` (
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `Ssn` char(9) NOT NULL,
  `Bdate` date DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Super_ssn` char(9) DEFAULT NULL,
  `Dno` int(11) NOT NULL,
  `Phone_number` char(12) DEFAULT NULL,
  PRIMARY KEY (`Ssn`),
  KEY `Super_ssn` (`Super_ssn`),
  KEY `Dno` (`Dno`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Super_ssn`) REFERENCES `EMPLOYEE` (`Ssn`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`Dno`) REFERENCES `DEPARTMENT` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table GAME
# ------------------------------------------------------------

DROP TABLE IF EXISTS `GAME`;

CREATE TABLE `GAME` (
  `prize` enum('small','medium','large') DEFAULT NULL,
  `price` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `maint_date` date DEFAULT NULL,
  `name` varchar(15) NOT NULL,
  `capacity` int(11) NOT NULL,
  `Dno` int(11) DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `name` (`name`),
  KEY `Dno` (`Dno`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`Dno`) REFERENCES `DEPARTMENT` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table KIOSK
# ------------------------------------------------------------

DROP TABLE IF EXISTS `KIOSK`;

CREATE TABLE `KIOSK` (
  `kiosk_id` int(11) NOT NULL,
  `service_type` enum('food','gifts') DEFAULT NULL,
  `name` varchar(15) NOT NULL,
  `Dno` int(11) DEFAULT NULL,
  PRIMARY KEY (`kiosk_id`),
  UNIQUE KEY `name` (`name`),
  KEY `Dno` (`Dno`),
  CONSTRAINT `kiosk_ibfk_1` FOREIGN KEY (`Dno`) REFERENCES `DEPARTMENT` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table RIDE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RIDE`;

CREATE TABLE `RIDE` (
  `ride_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `date_built` date DEFAULT NULL,
  `maintenance_date` date DEFAULT NULL,
  `name` varchar(15) NOT NULL,
  `rider_count` int(11) DEFAULT NULL,
  `rider_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Dno` int(11) DEFAULT NULL,
  PRIMARY KEY (`ride_id`),
  KEY `Dno` (`Dno`),
  CONSTRAINT `ride_ibfk_1` FOREIGN KEY (`Dno`) REFERENCES `DEPARTMENT` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table TICKET
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TICKET`;

CREATE TABLE `TICKET` (
  `ticket_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `type` enum('season','regular') DEFAULT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
