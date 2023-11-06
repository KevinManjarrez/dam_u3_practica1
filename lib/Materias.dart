import 'package:flutter/material.dart';
import 'Materia.dart';
import 'basededatos.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Materias extends StatefulWidget {
  const Materias({super.key});

  @override
  State<Materias> createState() => _MateriasState();
}

class _MateriasState extends State<Materias> {
  int _index = 0;
  String titulo = 'Materias';

  final idMateria = TextEditingController();
  final nombre = TextEditingController();
  final semestre = TextEditingController();
  final docente = TextEditingController();

  Materia matGlobal  =
  Materia(idMateria: "", nombre: "", semestre: "", docente: "");
  List<Materia> data= [];
  void actualizarLista() async {
    List<Materia> temp = await DB.mostrarTodos();
    setState(() {
      data = temp;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titulo)
        ),
        body: dinamico(),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Materias'),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tareas'),
      ], currentIndex: _index, onTap: (index) {
        setState(() {
          _index = index;
        });
      },
      )
    );
  }

  Widget dinamico() {
    switch (_index) {
      case 0:
        {
          return mostrarLista();
        }
      case 1:
        {
          return capturar();
        }
      case 2:
        {
          return const Center(
            child: Text('Hola mundo3'),
          );
        }
      default:
        return const Center(
          child: Text('Hola mundo default'),
        );
    }
  }

  Widget mostrarLista() {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, indice) {
          return ListTile(
            title: Text(data[indice].nombre),
            subtitle: Text(data[indice].docente),
            leading: CircleAvatar(
              radius: 15,
              child: Text(data[indice].nombre),
            ),
            trailing: IconButton(
              onPressed: () {
                DB.eliminar(data[indice].idMateria).then((value) {
                  setState(() {
                    titulo = "Se elimino!";
                  });
                  actualizarLista();
                });
              },
              icon: const Icon(Icons.delete),
            ),
            onTap: () {
              matGlobal = data[indice];
              setState(() {
                _index = 2;
              });
            },
          );
        });
  }

  Widget capturar() {
    return ListView(
      padding: const EdgeInsets.all(40),
      children: [
        TextField(
          controller: idMateria,
          decoration: const InputDecoration(labelText: "Num Control:"),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: nombre,
          decoration: const InputDecoration(labelText: "Nombre:"),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: semestre,
          decoration: const InputDecoration(labelText: "Carrera:"),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: docente,
          decoration: const InputDecoration(labelText: "Semestre:"),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  var temporal = Materia(
                      idMateria: idMateria.text,
                      nombre: nombre.text,
                      semestre: semestre.text,
                      docente: docente.text);

                  DB.insertar(temporal).then((value) {
                  });
                  idMateria.text = "";
                  nombre.text = "";
                  semestre.text = "";
                  docente.text = "";
                  mostrarToast("Se inserto con exito");
                  actualizarLista();
                },
                child: const Text("Insertar")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                },
                child: const Text("Cancelar")),
          ],
        )
      ],
    );
  }

  void mostrarToast(String texto) {
    Fluttertoast.showToast(
      msg: texto,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }





}