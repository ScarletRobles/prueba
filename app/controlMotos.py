from flask import render_template, request,current_app, redirect, url_for, flash, session
from app import app
from app.models import Motos, Marca, db
import os

@app.route('/motos')
def motos():
    motos = Motos.query.all()
    return render_template('motos.html', motos=motos)
#agregar motos
@app.route('/add_moto', methods=['GET', 'POST'])
def add_moto():
    if request.method == 'POST':
        nombre = request.form.get('nombre')
        cantidad = request.form.get('cantidad')
        precio = request.form.get('precio')
        foto = None
        marca_id = request.form.get('marca_id')
        
        if 'foto' in request.files:
            foto_file = request.files['foto']
            if foto_file.filename != '':
                foto = foto_file.filename
                foto_path = os.path.join('app/static/uploads', foto)
                foto_file.save(foto_path)
            
        nueva_moto = Motos(nombre=nombre, cantidad=int(cantidad), precio=int(precio), foto=foto, marca_id=int(marca_id))
    
        db.session.add(nueva_moto)
        db.session.commit()
        flash('moto agregada exitosamente.')
        return redirect(url_for('motos'))

    marcas = Marca.query.all()
    return render_template('add_moto.html', marcas=marcas)

#editar los caompos 
@app.route('/edit_motos/edit/<int:id>', methods=['GET', 'POST'])
def edit_moto(id):
    motos = Motos.query.get(id)
    if not motos:
        flash('Moto no encontrada.')
        return redirect(url_for('motos'))
    
    if request.method == 'POST':
        motos.nombre = request.form.get('nombre')
        motos.cantidad = request.form.get('cantidad')
        motos.precio = request.form.get('precio')
        motos.marca_id = request.form.get('marca_id')

        if not motos.nombre or not motos.cantidad or not motos.precio or not motos.marca_id:
            flash('Todos los campos son requeridos.')
            return redirect(url_for('edit_moto', id=id))
        
        if 'foto' in request.files:
            foto_file = request.files['foto']
            if foto_file.filename != '':                
                # Guardar la nueva foto
                foto = foto_file.filename
                uploads_dir = os.path.join(app.root_path, 'static/uploads')
                foto_path = os.path.join(uploads_dir, foto)
                os.makedirs(uploads_dir, exist_ok=True)
                foto_file.save(foto_path)
                motos.foto = foto  # Actualizar el campo foto en la base de datos
                print(f"Foto actualizada a: {foto}")

        db.session.commit()
        flash('Moto actualizada exitosamente.')
        print("Moto actualizada en la base de datos")
        return redirect(url_for('motos'))

    marcas = Marca.query.all()
    
    return render_template('edit_moto.html', motos=motos, marcas=marcas)

#eliminar un registro
@app.route('/delete_moto/delete/<int:id>', methods=['GET', 'POST'])
def delete_moto(id):
    motos = Motos.query.get(id)
    if not motos:
        flash('moto encontrada.')
        return redirect(url_for('motos'))
    
    db.session.delete(motos)
    db.session.commit()
    flash('moto eliminada correatamente')
    return redirect(url_for('motos'))

#ruta para la  buequeda de cada marca
@app.route('/buscar_motos')
def buscar_motos():
    query = request.args.get('query')
    if query:
        # Realizar la búsqueda en la base de datos
        motos = Motos.query.join(Marca).filter(
            (Motos.nombre.like(f'%{query}%')) | 
            (Marca.nombre.like(f'%{query}%'))
        ).all()
    else:
        motos = []

    return render_template('resultados.html', motos=motos, user_nombre=session['user_nombre'])
