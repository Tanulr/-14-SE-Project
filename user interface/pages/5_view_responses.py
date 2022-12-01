import streamlit as st
from database import *
from nav import *
import pandas as pd
import settings
import plotly.express as px

no_sidebar_style = """
    <style>
        div[data-testid="stSidebarNav"] {display: none;}
    </style>
"""
st.markdown(no_sidebar_style, unsafe_allow_html=True)

st.title("View Survey responses")

if not settings.status[-1]:
    st.warning("You must log-in to see the content of this sensitive page! Head over to the log-in page.")
    if st.button("Home page"):
        nav_page("")
    if st.button("Log in page"):
        nav_page("Log_in")
    if st.button("Sign up page"):
        nav_page("Sign_up")

else:
    userID = settings.userid[-1]

    polls = getpolls(userID)

    df = pd.DataFrame(polls, columns = ["Poll name"])

    pollname = st.selectbox("Poll names", list(df["Poll name"]))

    if st.button("View responses"):
        results = view_survey(pollname)
        df = pd.DataFrame(results, columns = ["User ID", "Question", "Response"])
        with st.expander("View responses"):
            st.dataframe(df)
        task_df = df['Response'].value_counts().to_frame()
        task_df = task_df.reset_index()
        p1 = px.pie(task_df, names='index', values='Response')
        st.plotly_chart(p1)

    if st.button("User profile"):
        nav_page("User_profile")