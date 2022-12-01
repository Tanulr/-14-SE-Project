import streamlit as st

def Signup(username, password, usertype):
    return

username = st.text_input("Username")
password = st.text_input("Password")
password2 = st.text_input("Confirm Password")
usertype = st.selectbox("Host?", ["Yes", "No"])
email = st.text_input("Email")
Phone = st.text_input("Phone number")
if st.button("Login"):
    if password!=password2:
        st.error("Passwords do not match")
    Signup(username, password, usertype)
