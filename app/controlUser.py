from flask import render_template, request, redirect, url_for, flash, session
from app import app
from app.models import Usuarios, db
from werkzeug.security import generate_password_hash, check_password_hash


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']
        telefono = request.form['telefono']
        
        # Hash de la contraseña
        clave_hash = generate_password_hash(clave)
        
        try:
            nuevo_usuarios = Usuarios(nombre=nombre, correo=correo, clave=clave_hash, telefono=telefono)
            db.session.add(nuevo_usuarios)
            db.session.commit()
            flash('Registro exitoso!', 'success')
            return redirect(url_for('login'))
        except Exception as e:
            flash(f'Error al registrar el usuario: {e}', 'error')
            return redirect(url_for('register'))
    
    return render_template('register.html')

@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        correo = request.form['correo']
        clave = request.form['clave']
        
        # Buscar el usuario por correo
        usuario = Usuarios.query.filter_by(correo=correo).first()
        
        if usuario and check_password_hash(usuario.clave, clave):
            session['user_id'] = usuario.id
            session['user_nombre'] = usuario.nombre
            flash('Inicio de sesión exitoso!', 'success')
            return redirect(url_for('base'))
        else:
            flash('Correo o contraseña incorrectos', 'error')
            return redirect(url_for('login'))
    
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    session.pop('user_nombre', None)
    flash('Has cerrado sesión correctamente.', 'success')
    return redirect(url_for('login'))

@app.route('/base')
def base():
    if 'user_id' not in session:
        flash('Por favor, inicia sesión primero.', 'warning')
        return redirect(url_for('login'))
    return render_template('base.html', user_nombre=session['user_nombre'])

@app.route('/index')
def index():
    return render_template('index.html')

@app.route('/base')
def honda():
    #path is filename string
    image_file = url_for('static', filename=honda)

    return render_template('base.html', image_file=honda.jpg)
