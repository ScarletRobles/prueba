#modelos o tablas de la bd
from app import db

class Usuarios(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nombre = db.Column(db.String(45))
    correo = db.Column(db.String(200))
    clave = db.Column(db.String(200))
    telefono = db.Column(db.BigInteger)

class Motos(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nombre = db.Column(db.String(45))
    cantidad = db.Column(db.Integer)
    precio = db.Column(db.Integer)
    foto = db.Column(db.String(200))
    marca_id = db.Column(db.Integer, db.ForeignKey('marca.id'), nullable=False)

class Marca(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nombre = db.Column(db.String(45))
    modelo = db.Column(db.String(45))
    serie = db.Column(db.String(45))

class Factura(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    fecha = db.Column(db.Date)
    total = db.Column(db.Integer)
    idUsuarios = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)


class DetalleFactura(db.Model):
    idfactura = db.Column(db.Integer, db.ForeignKey('factura.id'), primary_key=True, nullable=False)
    cantida = db.Column(db.Integer)
    precioU = db.Column(db.Integer)
    subtotal = db.Column(db.Integer)
    nombreM = db.Column(db.String(45))
    idMotos = db.Column(db.Integer, db.ForeignKey('motos.id'), primary_key=True, nullable=False)

class Carito(db.Model):
    idUsuarios = db.Column(db.Integer, db.ForeignKey('usuarios.id'), primary_key=True, nullable=False)
    nombreM = db.Column(db.String(45))
    cantidad = db.Column(db.Integer)
    precioU = db.Column(db.Integer)
    subtotal = db.Column(db.Integer)
    foto = db.Column(db.String(200))
    idMotos = db.Column(db.Integer, db.ForeignKey('motos.id'), primary_key=True, nullable=False)


 