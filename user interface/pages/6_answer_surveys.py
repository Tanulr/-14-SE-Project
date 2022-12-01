import streamlit as st
from database import *
from nav import *
import pandas as pd
import settings

st.write("Answer Survey")

if not settings.status[-1]:
    st.warning("You must log-in to see the content of this sensitive page! Head over to the log-in page.")
    if st.button("Home page"):
        nav_page("")
    if st.button("Log in page"):
        nav_page("Log_in")
    if st.button("Sign up page"):
        nav_page("Sign_up")

else:
    polls = getpollsall()

    df = pd.DataFrame(polls, columns = ["Poll name"])

    pollname = st.selectbox("Poll names", list(df["Poll name"]))

    
    qna = answer_survey(pollname)
    df1 = pd.DataFrame(qna, columns = ['Question', 'Answer'])
    qnadict = {}
    for ind, i in enumerate(list(df1['Question'])):
        if i not in qnadict.keys():
            qnadict[i] = [df1['Answer'].iloc[ind]]
        else:
            qnadict[i].append(df1['Answer'].iloc[ind])
    
    keys = list(qnadict.keys())
    values = list(qnadict.values())
    votes = []
    for i in range(len(keys)):
        x = st.selectbox(keys[i], values[i])
        votes.append(x)
    
    if st.button("Submit"):
        st.success("Response submitted")

    if st.button("User profile"):
        nav_page("User_profile")


     
        

        
        