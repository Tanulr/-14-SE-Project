import streamlit as st
from database import *
from nav import *
import settings

no_sidebar_style = """
    <style>
        div[data-testid="stSidebarNav"] {display: none;}
    </style>
"""
st.markdown(no_sidebar_style, unsafe_allow_html=True)

st.title("Log in")

if settings.status[-1]:
    st.warning("You are already logged in.")
    st.stop()

def Login(username, password):
    if sqllogin(username, password):
        settings.status.append(True)
        st.success("Login successful")
        nav_page("User_Profile")
            
    else:
        st.error("Login Failed")

username = st.text_input("Username")
password = st.text_input("Password")

if st.button("Login"):
    if username =="" or password == "":
        st.error("Fields empty")
    else:
        Login(username, password)

if st.button("Sign up"):
    nav_page("Sign_up")

if st.button("Home"):
    nav_page("")
