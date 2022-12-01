import streamlit as st
from database import *

def Login(username, password):
    if sqllogin(username, password):
        st.success("Login successful")
        st.session_state.page = 3
    else:
        st.error("Login Failed")

    

username = st.text_input("Username")
password = st.text_input("Password")

if st.button("Login"):
    if username =="" or password == "":
        st.error("Fields empty")
    else:
        Login(username, password)
