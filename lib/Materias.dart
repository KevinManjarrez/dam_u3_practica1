import 'package:flutter/material.dart';
import 'Materia.dart';
import 'basededatos.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Tareas.dart';

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

  Materia matGlobal =
      Materia(idMateria: "", nombre: "", semestre: "", docente: "");
  List<Materia> data = [];

  void actualizarLista() async {
    List<Materia> temp = await DB.mostrarTodos();
    setState(() {
      data = temp;
    });
  }

  void initState() {
    super.initState();
    actualizarLista();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: dinamico(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.subject), label: 'Materias'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Agregar'),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Editar'),
          ],
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ));
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
                  titulo = "Se eliminó!";
                });
                actualizarLista();
              });
            },
            icon: Icon(Icons.delete),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Tareas(materia: data[indice]),
              ),
            );
          },
        );
      },
    );
  }


  Widget capturar() {
    return ListView(
      padding: const EdgeInsets.all(40),
      children: [
        TextField(
          controller: idMateria,
          decoration: const InputDecoration(labelText: "idMateria:"),
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
          decoration: const InputDecoration(labelText: "Semestre:"),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: docente,
          decoration: const InputDecoration(labelText: "Docente:"),
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
                    mostrarToast("Se inserto con exito");
                  });
                  idMateria.text = "";
                  nombre.text = "";
                  semestre.text = "";
                  docente.text = "";
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

  void actualizar() {
    nombre.text = matGlobal.nombre;
    semestre.text = matGlobal.semestre;
    docente.text = matGlobal.docente;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 5,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
                top: 15,
                left: 30,
                right: 30,
                bottom: MediaQuery.of(context).viewInsets.bottom + 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombre,
                  decoration: const InputDecoration(
                    labelText: "Nombre: ",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: semestre,
                  decoration: const InputDecoration(labelText: "Semestre: "),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: docente,
                  decoration: const InputDecoration(labelText: "Docente:"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        matGlobal.nombre = nombre.text;
                        matGlobal.semestre = semestre.text;
                        matGlobal.docente = docente.text;
                        DB.actualizar(matGlobal).then((value) {
                          if (value > 0) {
                            mostrarToast("Se actualizo con exito");
                            nombre.text = "";
                            semestre.text = "";
                            docente.text = "";
                            matGlobal = Materia(
                                idMateria: "",
                                nombre: "",
                                semestre: "",
                                docente: "");
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Actualizar"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cerrar"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
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
