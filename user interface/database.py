import mysql.connector 
import pandas as pd
import settings

mydb = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "",
    database = "survey"
)

c = mydb.cursor()

def sqllogin(userID, password):
    c.execute('SELECT id FROM USER WHERE ID = %s and passwordHash = %s',(userID, password))
    user = c.fetchall()
    df = pd.DataFrame(user)
    if len(df)==0:
        return False
    return True

def sqlsignup(userID, username, phone, email, password):
    c.execute('INSERT INTO USER(id, name, mobile, email, passwordHash) VALUES (%s, %s, %s, %s, %s)', (userID, username, phone, email, password))

def create_poll(ID,title,summary):
    c.execute('INSERT INTO POLL(ID,hostID,title,summary) VALUES (%s, %s, %s, %s)', (ID,settings.userid[-1],title,summary))
    
def poll_questions(q_id,pollId,type,content):
    if type=="MCQ":
        type = 2
    else:
        type = 1
    c.execute('INSERT INTO POLL_QUESTION(ID,pollid,type,content) VALUES (%s, %s, %s, %s)', (q_id,pollId,type,content))

def poll_answers(a_id,pollId,q_id,content):
    c.execute('INSERT INTO POLL_ANSWER(ID,pollid,questionid,content) VALUES (%s, %s, %s, %s)', (a_id,pollId,q_id,content))


def getpolls(userID):
    c.execute('SELECT title FROM poll WHERE hostID = %s',(userID,))
    polls = c.fetchall()
    return polls

def view_survey(pollname):
    c.execute('SELECT T.Uid, poll_question.content, T.content from poll_question join (SELECT S.pollId as Pid, S.questionId as Qid, S.userID as Uid, content from poll_answer join (SELECT pollId, answerId, questionId, userID FROM poll join poll_vote where poll.id = poll_vote.pollId and poll.title = %s) as S where poll_answer.id = S.answerId) as T where poll_question.id = T.Qid order by T.QId;', (pollname,))
    result = c.fetchall()
    return result
    
def getpollsall():
    c.execute('SELECT title FROM poll')
    polls = c.fetchall()
    return polls


def answer_survey(pollname):
    c.execute("SELECT T.question, poll_answer.content from (SELECT poll_question.content as question, poll_question.id as qid from (SELECT id from poll where poll.title = %s) as S join poll_question where poll_question.pollId = S.id) as T join poll_answer where poll_answer.questionId = T.qid;", (pollname,))
    qna = c.fetchall()
    return qna