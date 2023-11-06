import 'package:flutter/material.dart';
import 'Materia.dart';
import 'Tarea.dart';
import 'basededatos.dart';
import 'CrearTarea.dart';

class Tareas extends StatefulWidget {
  final Materia materia;

  const Tareas({super.key, required this.materia});

  @override
  _TareasState createState() => _TareasState();
}

class _TareasState extends State<Tareas> {
  List<Tarea> tareas = [];


  void cargarTareas() async {
    List<Tarea> tareasCargadas = await DB.obtenerTareasPorMateria(widget.materia.idMateria);
    setState(() {
      tareas = tareasCargadas;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarTareas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas de ${widget.materia.nombre}'),
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, indice) {
          return ListTile(
            title: Text(tareas[indice].nombre),
            subtitle: Text('Fecha de entrega: ${tareas[indice].fechaEntrega}'),
            leading: CircleAvatar(
              radius: 15,
              child: Text(tareas[indice].idMateria),
            ),
            // Agregar más detalles de la tarea si es necesario.
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de CrearTarea
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CrearTarea(materia: widget.materia),
            ),
          ).then((result) {
            if (result == true) {
              cargarTareas(); // Recargar las tareas después de crear una nueva
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

