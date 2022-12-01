import streamlit as st
import settings
from nav import *

st.set_page_config(
    page_title="Home",
    page_icon="👋",
)

no_sidebar_style = """
    <style>
        div[data-testid="stSidebarNav"] {display: none;}
    </style>
"""
st.markdown(no_sidebar_style, unsafe_allow_html=True)

st.write("# Welcome to Survey Website! 👋")
st.write("\n\n\n\n\n\n\n\n\n\n\n")
col1, col2 = st.columns(2)
with col1:
    if st.button("Log in"):
        nav_page("Log_in")
with col2:
    if st.button("Sign up"):
        nav_page("Sign_up")