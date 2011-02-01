# MySQL-Front 5.0  (Build 1.0)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: localhost    Database: dictionary
# ------------------------------------------------------
# Server version 5.0.51b-community-nt

DROP DATABASE IF EXISTS `dictionary`;
CREATE DATABASE `dictionary` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dictionary`;

#
# Table structure for table english
#

CREATE TABLE `english` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `word` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Table structure for table english_to_russian
#

CREATE TABLE `english_to_russian` (
  `id` int(11) unsigned NOT NULL default '0',
  `word_id` int(11) unsigned default NULL,
  `translation_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Table structure for table russian
#

CREATE TABLE `russian` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `word` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
