import 'package:flutter/material.dart';

import 'Materias.dart';

class Practica1 extends StatefulWidget {
  const Practica1({super.key});

  @override
  State<Practica1> createState() => _Practica1State();
}

class _Practica1State extends State<Practica1> {
  int indice = 0;
  String titulo = 'Practica 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: dinamico(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Image(
                      image: AssetImage('assets/usuario.png'),
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            _itemMenu(Icons.book_online_outlined, 'Materias', 0),
            _itemMenu(Icons.task, 'Tareas', 1),

          ],
        ),
      ),
    );
  }

  Widget dinamico() {
    switch (indice) {
      case 0:
        {
          return const Materias();
        }
        case 1:
        {
          return const Center(
            child: Text('Hola mundo2'),
          );
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

  _itemMenu(IconData icono, String t, int i) {
    return ListTile(
      leading: Icon(icono),
      title: Text(t),
      onTap: () {
        setState(() {
          indice = i;
          titulo = t;
        });
        Navigator.pop(context);
      },
    );
  }



}
