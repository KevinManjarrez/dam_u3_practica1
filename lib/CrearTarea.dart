import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Importa fluttertoast
import 'Materia.dart';
import 'Tarea.dart';
import 'basededatos.dart';
import 'Tareas.dart'; // Asegúrate de importar la pantalla de Tareas

class CrearTarea extends StatefulWidget {
  final Materia materia;

  CrearTarea({required this.materia});

  @override
  _CrearTareaState createState() => _CrearTareaState();
}

class _CrearTareaState extends State<CrearTarea> {
  final nombreController = TextEditingController();
  final fechaEntregaController = TextEditingController();
  final descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Tarea para ${widget.materia.nombre}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre de la tarea'),
            ),
            TextField(
              controller: fechaEntregaController,
              decoration: InputDecoration(labelText: 'Fecha de entrega'),
            ),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(labelText: 'Descripción de la tarea'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Guardar la tarea en la base de datos
          Tarea nuevaTarea = Tarea(
            idTarea: 0, // Puedes generar un ID o utilizar el que prefieras
            idMateria: widget.materia.idMateria,
            nombre: nombreController.text,
            fechaEntrega: fechaEntregaController.text,
            descripcion: descripcionController.text,
          );
          DB.insertarTarea(nuevaTarea).then((value) {
            // Mostrar un Toast para confirmar que se guardó la tarea
            Fluttertoast.showToast(
              msg: 'Tarea guardada',
              gravity: ToastGravity.BOTTOM, // Cambia la posición según tu preferencia
              timeInSecForIosWeb: 2, // Duración del mensaje
            );

            // Después de agregar la tarea, navegar a la pantalla de Tareas
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Tareas(materia: widget.materia),
              ),
            );
          });
        },
        child: Icon(Icons.save),
      ),
    );
  }
}


