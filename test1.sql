DROP DATABASE IF EXISTS `libraries`;

CREATE DATABASE `libraries`
    CHARACTER SET 'cp1251'
    COLLATE 'cp1251_general_ci';

USE `libraries`;

CREATE TABLE `books` (
  `id_lib` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `series` varchar(100) DEFAULT NULL,
  `counts` int(11) DEFAULT NULL,
  `years` int(5) DEFAULT NULL,
  `id_pub` int(11) NOT NULL,
  `id_book` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_book`),
  KEY `id_lib` (`id_lib`),
  KEY `id_pub` (`id_pub`),
  CONSTRAINT `books_fk1` FOREIGN KEY (`id_pub`) REFERENCES `publishers` (`id_pub`),
  CONSTRAINT `books_fk` FOREIGN KEY (`id_lib`) REFERENCES `library` (`id_lib`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE `library` (
  `id_lib` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  PRIMARY KEY (`id_lib`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE `publishers` (
  `id_pub` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `adress` varchar(100) NOT NULL,
  `phone` int(12) DEFAULT NULL,
  PRIMARY KEY (`id_pub`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE `readers` (
  `id_ticket` int(11) NOT NULL AUTO_INCREMENT,
  `fam` varchar(100) NOT NULL,
  `nam` varchar(100) NOT NULL,
  `adress` varchar(100) NOT NULL,
  `birth` date NOT NULL,
  `phone` int(12) DEFAULT NULL,
  PRIMARY KEY (`id_ticket`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE `returns` (
  `id_ticket` int(11) NOT NULL,
  `id_book` int(11) NOT NULL,
  `issues` date NOT NULL,
  `returns` date NOT NULL,
  `real_returns` date NOT NULL,
  `id_return` int(11) NOT NULL AUTO_INCREMENT,
  `id_lib` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_return`),
  KEY `id_ticket` (`id_ticket`),
  KEY `id_book` (`id_book`),
  CONSTRAINT `returns_fk` FOREIGN KEY (`id_ticket`) REFERENCES `readers` (`id_ticket`),
  CONSTRAINT `returns_fk1` FOREIGN KEY (`id_book`) REFERENCES `books` (`id_book`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=cp1251;

commit;