import streamlit as st
import settings
from database import *
from nav import *

no_sidebar_style = """
    <style>
        div[data-testid="stSidebarNav"] {display: none;}
    </style>
"""
st.markdown(no_sidebar_style, unsafe_allow_html=True)

st.title("Sign Up")

if settings.status[-1]:
    st.warning("You are already logged in.")
    st.stop()

def Signup(userID, username, phone, email, password):
    sqlsignup(userID, username, phone, email, password)
    settings.status.append(True)
    nav_page("User_Profile")

username = st.text_input("Username")
userID = st.text_input("User ID")
email = st.text_input("Email")
phone = st.text_input("Phone number")
password = st.text_input("Password")
password2 = st.text_input("Confirm Password")

if st.button("Sign Up"):
    if password!=password2:
        st.error("Passwords do not match")
    else:
        Signup(userID, username, phone, email, password)

if st.button("Log in"):
    nav_page("Log_in")

if st.button("Home"):
    nav_page("")