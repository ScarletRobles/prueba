# conexion a la bd
class config:
    SQLALCHEMY_DATABASE_URI = 'mysql://root:@localhost/mundosbk'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = 'your_secret_key'