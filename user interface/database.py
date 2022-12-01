import mysql.connector 
import pandas as pd

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
