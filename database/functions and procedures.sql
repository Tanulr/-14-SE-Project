-- FUNCTION -----------------------
-- See if user has attempted all the questions in the poll

use survey;

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