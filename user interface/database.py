import mysql.connector 
import pandas as pd
import settings

mydb = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "Rhea@1912",
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
def view_survey():
    return

def answer_survey():
    return 