-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 04, 2012 at 10:19 AM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `figures`
--

-- --------------------------------------------------------

--
-- Table structure for table `blocks`
--

CREATE TABLE IF NOT EXISTS `blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Shape` varchar(20) NOT NULL,
  `color` varchar(20) NOT NULL,
  `side1` int(11) NOT NULL,
  `side2` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `blocks`
--

INSERT INTO `blocks` (`id`, `Shape`, `color`, `side1`, `side2`) VALUES
(1, 'triangle', 'red', 5, 0),
(2, 'square', 'red', 5, 0),
(3, 'rectangle', 'red', 2, 4),
(4, 'circle', 'red', 5, 0),
(5, 'circle', 'blue', 2, 0),
(6, 'square', 'blue', 7, 0),
(7, 'square', 'yellow', 8, 0),
(8, 'triangle', 'yellow', 2, 0),
(9, 'triangle', 'blue', 3, 0),
(10, 'circle', 'green', 10, 0),
(11, 'square', 'green', 1, 0),
(12, 'square', 'cyan', 4, 4),
(13, 'rectangle', 'cyan', 7, 8),
(14, 'rectangle', 'yellow', 5, 2),
(15, 'rectangle', 'white', 2, 10),
(16, 'circle', 'white', 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `block_qty`
--

CREATE TABLE IF NOT EXISTS `block_qty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `block_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `block_qty`
--

INSERT INTO `block_qty` (`id`, `block_id`, `qty`) VALUES
(1, 1, 7),
(2, 2, 5),
(3, 3, 3),
(4, 4, 2),
(5, 5, 0),
(6, 6, 5),
(7, 7, 5),
(8, 8, 8),
(9, 9, 4),
(10, 10, 8),
(11, 11, 8),
(12, 12, 6),
(13, 13, 6),
(14, 14, 1),
(15, 15, 7);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
