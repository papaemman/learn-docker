#######################
#                     #
#   Simple Dash App   #
#                     #
#######################

# Imports
from dash import Dash, html


app = Dash()
server = app.server

app.layout = html.Div(
    [
        html.H1("Dash App"),
        html.P("App is Running...")
        
    ]
)

if __name__ == "__main__":
    app.run()
    