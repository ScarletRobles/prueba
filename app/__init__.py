# inicializador de la app 
from flask import Flask
from config import config
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object(config) #configuracion de la clase config
db = SQLAlchemy(app)

from app import controlMotos
from app import controlUser

