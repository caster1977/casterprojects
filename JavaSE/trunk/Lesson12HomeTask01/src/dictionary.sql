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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
INSERT INTO `english` VALUES (1,'table');
INSERT INTO `english` VALUES (2,'sun');
INSERT INTO `english` VALUES (3,'tree');
INSERT INTO `english` VALUES (4,'window');
INSERT INTO `english` VALUES (5,'wood');

#
# Table structure for table english_to_russian
#

CREATE TABLE `english_to_russian` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `word_id` int(11) unsigned default NULL,
  `translation_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
INSERT INTO `english_to_russian` VALUES (1,1,1);
INSERT INTO `english_to_russian` VALUES (2,1,2);
INSERT INTO `english_to_russian` VALUES (3,2,3);
INSERT INTO `english_to_russian` VALUES (4,3,5);
INSERT INTO `english_to_russian` VALUES (5,4,4);
INSERT INTO `english_to_russian` VALUES (6,5,5);

#
# Table structure for table russian
#

CREATE TABLE `russian` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `word` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
INSERT INTO `russian` VALUES (1,'tablica');
INSERT INTO `russian` VALUES (2,'stol');
INSERT INTO `russian` VALUES (3,'solnce');
INSERT INTO `russian` VALUES (4,'okno');
INSERT INTO `russian` VALUES (5,'derevo');

#
# Table structure for table russian_to_english
#

CREATE TABLE `russian_to_english` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `word_id` int(11) unsigned default NULL,
  `translation_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
INSERT INTO `russian_to_english` VALUES (1,1,1);
INSERT INTO `russian_to_english` VALUES (2,2,1);
INSERT INTO `russian_to_english` VALUES (3,3,2);
INSERT INTO `russian_to_english` VALUES (4,4,4);
INSERT INTO `russian_to_english` VALUES (5,5,3);
INSERT INTO `russian_to_english` VALUES (6,5,5);

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;