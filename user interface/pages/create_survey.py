import streamlit as st
from database import *

st.write("Create Survey")

pollID = st.text_input("Poll ID")
title = st.text_input("Title")
summary = st.text_input("Summary")

if st.button("Create Poll"):
    create_poll(pollID,title,summary)
    st.success("Poll Created!")


question_num = st.text_input("Enter question number")
type = st.selectbox("Type of question",('MCQ','Yes/No'))
content = st.text_input("Enter your question")
if st.button("Add your question"):
    poll_questions(pollID,question_num,type,content)
    st.success("Question Added")

answer_id = st.text_input("Enter answer id")
ans_content = st.text_input("Enter the answer")
if st.button("Add your answer"):
    poll_answers(answer_id,pollID,question_num,ans_content)
    st.success("Answer added!")