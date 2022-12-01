from database import *
import pandas as pd

def test_login_1():
    value = sqllogin('1', '56gH')
    assert value == True

def test_login_2():
    value = sqllogin('2', '1231313')
    assert value == False

def test_polls_1():
    polls = len(pd.DataFrame(getpolls('1')))
    assert polls>0
    
def test_polls_2():
    polls = len(pd.DataFrame(getpolls('1221')))
    assert polls==0

def test_answers_1():
    qna = answer_survey('Favourite anime')
    qna = len(pd.DataFrame(qna))
    assert qna>0

def test_answers_2():
    qna = answer_survey('Favourite ')
    qna = len(pd.DataFrame(qna))
    assert qna==0

def test_surveyview1():
    result = len(pd.DataFrame(view_survey('Favourite anime')))
    assert result>0

def test_surveyview2():
    result = len(pd.DataFrame(view_survey('Favournime')))
    assert result==0
