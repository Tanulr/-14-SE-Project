-- Queries ------------------------------------

use survey;

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

SELECT T.content, T.Uid, poll_question.content from poll_question join (SELECT S.pollId as Pid, S.questionId as Qid, S.userID as Uid, content from poll_answer join (SELECT pollId, answerId, questionId, userID FROM 
poll join poll_vote where poll.id = poll_vote.pollId and poll.title = 'Favourite anime') as S where poll_answer.id = S.answerId) as T where poll_question.id = T.Qid order by T.QId;

