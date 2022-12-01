-- TRIGGER ------------------------
-- user cant attempt a question twice, raise error

use survey;

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