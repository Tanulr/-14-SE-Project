-- DDL; Making the schema ---------------------------------
CREATE SCHEMA `survey` ;

use survey;

SET NAMES utf8 ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;

SET character_set_client = utf8mb4 ;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `passwordHash` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_mobile` (`mobile`),
  UNIQUE KEY `uq_email` (`email`)
);

--
-- Table structure for table `poll`
--

DROP TABLE IF EXISTS `poll`;

SET character_set_client = utf8mb4 ;

CREATE TABLE `poll` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hostId` bigint(20) NOT NULL,
  `title` varchar(75) NOT NULL,
  `summary` tinytext,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_poll_host` FOREIGN KEY (`hostId`) REFERENCES `user` (`id`)
);

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;

SET character_set_client = utf8mb4 ;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentId` bigint(20) DEFAULT NULL,
  `title` varchar(75) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`parentId`) REFERENCES `category` (`id`)
);

--
-- Table structure for table `poll_category`
--

DROP TABLE IF EXISTS `poll_category`;
SET character_set_client = utf8mb4 ;
CREATE TABLE `poll_category` (
  `pollId` bigint(20) NOT NULL,
  `categoryId` bigint(20) NOT NULL,
  PRIMARY KEY (`pollId`,`categoryId`),
  CONSTRAINT `fk_pc_category` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_pc_poll` FOREIGN KEY (`pollId`) REFERENCES `poll` (`id`)
);

--
-- Table structure for table `poll_question`
--

DROP TABLE IF EXISTS `poll_question`;
SET character_set_client = utf8mb4 ;
CREATE TABLE `poll_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pollId` bigint(20) NOT NULL,
  `type` varchar(50) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_question_poll` FOREIGN KEY (`pollId`) REFERENCES `poll` (`id`)
);

--
-- Table structure for table `poll_answer`
--

DROP TABLE IF EXISTS `poll_answer`;
SET character_set_client = utf8mb4 ;
CREATE TABLE `poll_answer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pollId` bigint(20) NOT NULL,
  `questionId` bigint(20) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_answer_poll` FOREIGN KEY (`pollId`) REFERENCES `poll` (`id`),
  CONSTRAINT `fk_answer_question` FOREIGN KEY (`questionId`) REFERENCES `poll_question` (`id`)
);

--
-- Table structure for table `poll_vote`
--

DROP TABLE IF EXISTS `poll_vote`;
SET character_set_client = utf8mb4 ;
CREATE TABLE `poll_vote` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pollId` bigint(20) NOT NULL,
  `questionId` bigint(20) NOT NULL,
  `answerId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vote_answer` FOREIGN KEY (`answerId`) REFERENCES `poll_answer` (`id`),
  CONSTRAINT `fk_vote_poll` FOREIGN KEY (`pollId`) REFERENCES `poll` (`id`),
  CONSTRAINT `fk_vote_question` FOREIGN KEY (`questionId`) REFERENCES `poll_question` (`id`),
  CONSTRAINT `fk_vote_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
);


