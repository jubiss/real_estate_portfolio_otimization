import sys,os
sys.path.append(os.getcwd())
from dash import html, dcc

introduction_section = html.Div([
    html.H3('Introduction'),
    html.P("""
    In this project the main focus is to precify appartament prices. 
    The information of predictions will be used as an opportunity to find appartaments bellow 
    the Market Price. But some steps are required to reach this goal."""),
    html.Br(),
    html.Ol([
        html.Li("Final Model Results"),
        html.Li("Exploration and data Treatment"),
        html.Li("Feature Engineering"),
        html.Li("Feature importance"),
        html.Li("Future Development"),
    ])
])

final_model_results = html.Div([])

layout = html.Div([introduction_section,
                   final_model_results])