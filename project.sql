-- DDL; Making the schema ---------------------------------
CREATE SCHEMA `poll_proj` ;

use poll_proj;

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
  `host` tinyint(1) NOT NULL DEFAULT '0',
  `registeredAt` datetime NOT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `intro` tinytext,
  `profile` text,
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
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `startsAt` datetime DEFAULT NULL,
  `endsAt` datetime DEFAULT NULL,
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
  `createdAt` datetime NOT NULL,
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
  `createdAt` datetime NOT NULL,
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
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vote_answer` FOREIGN KEY (`answerId`) REFERENCES `poll_answer` (`id`),
  CONSTRAINT `fk_vote_poll` FOREIGN KEY (`pollId`) REFERENCES `poll` (`id`),
  CONSTRAINT `fk_vote_question` FOREIGN KEY (`questionId`) REFERENCES `poll_question` (`id`),
  CONSTRAINT `fk_vote_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
);


-- Populating the database ------------------------------

INSERT INTO user
values 
(1,	"Tom",	456,	"tom@poll.com",	"56gH",	1,	"2022-07-22 08:09:18",	"2022-11-15 15:09:18",	"Tom",	"Hi I'm Tom"),
(2,	"Hanks",	345,	"hanks@poll.com",	"b123",	0,	"2022-08-22 08:09:18",	"2022-11-14 15:09:18",	"Hanks",	"Hi I'm Hanks"),
(3,	"Meg",	234,	"meg@poll.com",	"8Jk9",	1,	"2022-09-22 08:09:18",	"2022-11-08 15:09:18",	"Meg",	"Hi I'm Meg"),
(4,	"Ryan",	123,	"ryan@poll.com",	"02k8",	0,	"2022-10-22 08:09:18",	"2022-11-04 15:09:18",	"Ryan",	"Hi I'm Ryan");

INSERT INTO poll
values
(1,	1,	"Favourite anime",	"Fun",	1,	"2022-09-22 08:09:18",	"2022-09-20 08:09:18"	,"2022-09-27 08:09:18",	"2022-10-22 08:09:18"	),
(2,	3,	"Happiness Quotient",	"Company",	1,	"2022-08-22 08:09:18",	"2022-08-19 08:09:18"	,"2022-08-29 08:09:18",	"2022-10-22 08:09:18");

INSERT INTO poll_question
values
(1	,1,	1	,"2022-09-20 08:09:18",	"Action is better than horror"),
(2	,1	,1	,"2022-09-20 08:09:18"	,"Boys secretly like romance"),
(3,	1	,1	,"2022-09-20 08:09:18"	,"Deathnote is all time best anime"),
(4	,2	,2	,"2022-08-19 08:09:18",	"Best workplace"),
(5	,2	,2	,"2022-08-19 08:09:18"	,"What symptoms when you're stressed"),
(6,	2	,1,	"2022-08-19 08:09:18"	,"Do you think you're trully happy");


INSERT INTO poll_answer
values
(1	,1,	1	,"2022-09-20 08:09:18"	,"Yes"),
(2,	1	,1	,"2022-09-20 08:09:18"	,"No"),
(3	,1	,2	,"2022-09-20 08:09:18"	,"Yes"),
(4,	1	,2	,"2022-09-20 08:09:18"	,"No"),
(5	,1	,3	,"2022-09-20 08:09:18"	,"Yes"),
(6,	1	,3	,"2022-09-20 08:09:18"	,"No"),
(7	,2	,4	,"2022-08-19 08:09:18"	,"At home"),
(8,	2	,4	,"2022-08-19 08:09:18"	,"Workplace"),
(9	,2	,4	,"2022-08-19 08:09:18"	,"Co-working space"),
(10,2	,5,	"2022-08-19 08:09:18",	"Indigestion"),
(11	,2	,5	,"2022-08-19 08:09:18"	,"Anxiety"),
(12,2	,5,	"2022-08-19 08:09:18",	"Cry"),
(13	,2	,6	,"2022-08-19 08:09:18"	,"Yes"),
(14,2,	6,	"2022-08-19 08:09:18",	"No");

INSERT INTO category
values
(1	,1,	"Past-time"	,"Fun and friendly"),
(2,	2	,"Serious",	"Corporate survey");

INSERT INTO poll_category
values
(1,	1),
(2,	2);

INSERT INTO poll_vote
values
(1,	1,	1,	1,	1,	"2022-09-29 08:09:18"),
(2,	1,	2,	4,	1,	"2022-09-29 08:09:18"),
(3,	1,	3,	5,	1,	"2022-09-29 08:09:18"),
(4,	2,	4,	8,	2,	"2022-09-29 08:09:18"),
(5,	2,	5,	11,	2,	"2022-09-29 08:09:18"),
(6,	2,	6,	13,	2,	"2022-09-29 08:09:18"),
(7,	1,	1,	2,	3,	"2022-09-29 08:09:18"),
(8	,1,	2,	4,	3,	"2022-09-29 08:09:18"),
(9	,1,	3,	6,	3,	"2022-09-29 08:09:18"),
(10	,2,	4,	7,	4,	"2022-09-29 08:09:18"),
(11	,2,	5,	10,	4,	"2022-09-29 08:09:18"),
(12	,2,	6,	12,	4,	"2022-09-29 08:09:18");


-- Queries ------------------------------------

-- JOINS --------------------------
-- 1. Display all members who took part in pollid = 1
SELECT U.name, U.id, profile
FROM user as U JOIN poll as P on U.id = P.hostid;

-- 2. Show all the votes done on poll 2
SELECT N.name, pollid, profile 
FROM 
(SELECT name, pollid, profile
FROM user INNER join poll_question as P on user.id = P.pollid) as N
WHERE pollid = 2;

-- 3. Find the parent category of each category
SELECT pollid, id, categoryid
FROM
category as C LEFT JOIN poll_category as P on C.id = P.categoryid;

-- 4. Display all the answers associated with pollid = 2, questionid = 4
SELECT Q.content as "Question", P.content as "Answer"
FROM poll_answer as P LEFT JOIN poll_question as Q
on P.pollid = Q.pollid
WHERE P.pollid = 2 and P.questionid = 4;

-- AGGREGATE ----------------------
-- 1. Number of active polls
SELECT count(*)
FROM poll
WHERE poll.endsat > now();

-- 2. Number of questions per poll
SELECT pollid, count(*)
FROM poll_question
GROUP BY pollid;

-- 3. Number of possible answers per question per poll
SELECT pollid, questionid, count(*)
FROM poll_answer
GROUP BY questionid;

-- 4. Select question with maximum number of answers 
WITH T(pollid, questionid, count) AS
(SELECT pollid, questionid, count(*)
FROM poll_answer
GROUP BY questionid)
SELECT T.questionid 
FROM T
WHERE count = (SELECT MAX(count) from T);

-- SET ---------------------------
-- 1. Display polls created after "2022-09-00" and before "2022-10-00"
SELECT id, title, summary
FROM poll
WHERE createdAt > "2022-09-01"
AND EXISTS
(SELECT id, title, summary
FROM poll
WHERE createdAt < "2022-10-01");

-- 2. Select all answers related to questionid = 2 and questionid = 4
SELECT pollid, questionid, content
FROM poll_answer
WHERE questionid = 2
UNION
SELECT pollid, questionid, content
FROM poll_answer
WHERE questionid = 4;

-- 3. Show all users who's last login is after "2022-11-01" and they have not taken part in pollid = 2
SELECT id, name, intro
FROM user
WHERE lastlogin > "2022-11-01"
AND NOT EXISTS
(SELECT user.id, name, intro
FROM user, poll_vote
WHERE poll_vote.pollid = 2);

-- 4. Show answers created after "2022-09-01" and questions from pollid = 2
SELECT id, content
FROM poll_answer
WHERE createdat > "2022-09-01"
UNION
SELECT id, content
FROM poll_answer
WHERE pollid = 2;

-- FUNCTION -----------------------
-- See if user has attempted all the questions in the poll

DELIMITER $$
CREATE FUNCTION can_try(U_ID bigint, P_ID bigint)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(50);
    DECLARE p_count int;
    DECLARE u_count int;
    
    SELECT count(*) into p_count
    FROM poll_question  
    WHERE pollid = P_ID;
    
    SELECT count(*) into u_count
    FROM poll_vote  
    WHERE pollid = P_ID AND userid = U_ID;
    
	IF u_count = p_count THEN
		SET result = 'User has successfully completed the poll.';
	ELSE
		SET result = 'User has missed out some questions';
	END IF;
		RETURN result;
END; $$
DELIMITER ;

SELECT can_try(1, 1); 

-- PROCEDURE ------------------------ 
-- update an answer

DELIMITER $$
CREATE procedure updat_ans(IN U_ID int, IN p_id int, IN q_id int, IN ans int)
BEGIN
UPDATE poll_vote set answerid = ans where userID = U_ID and pollid = p_id and questionid = q_id;
END;$$
DELIMITER ;

SELECT * from poll_vote WHERE userid = 1 and pollid = 1 and questionid = 1;
CALL updat_ans(1, 1, 1, 1);
SELECT * from poll_vote WHERE userid = 1 and pollid = 1 and questionid = 1;


-- TRIGGER ------------------------
-- user cant attempt a question twice, raise error

DELIMITER @@
CREATE TRIGGER BeforeInsert
BEFORE INSERT
ON poll_vote FOR EACH ROW
BEGIN
DECLARE error_msg VARCHAR(255);
DECLARE n int;
SET error_msg = ('User has already attempted this question.');
SELECT count(*) into n from poll_vote where new.userid = userid AND new.questionid = questionid;
IF n>=1 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = error_msg;  
END IF;  
END @@
DELIMITER ;

insert into poll_vote values (1, 1,	1,	1,	1,	"2022-09-29 08:09:18");

-- Execution plan --------------------------------
-- Show all answers for pollid = 2, questionid = 5
SELECT Q.content as "Question", P.content as "Answer"
FROM poll_answer as P LEFT JOIN poll_question as Q
on P.pollid = Q.pollid
WHERE P.pollid = 2 and P.questionid = 5;

SELECT Q.content, A.content
FROM poll_question as Q, poll_answer as A
WHERE A.questionid = 5 AND A.pollid = 2;
