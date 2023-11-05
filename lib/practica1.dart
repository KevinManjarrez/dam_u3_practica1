import 'package:flutter/material.dart';

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
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Practica 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Practica 1'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 1';
                  indice = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Practica 2'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 2';
                  indice = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Practica 3'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 3';
                  indice = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Practica 4'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 4';
                  indice = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Practica 5'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 5';
                  indice = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Practica 6'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 6';
                  indice = 5;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Practica 7'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 7';
                  indice = 6;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Practica 8'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 8';
                  indice = 7;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Practica 9'),
              onTap: () {
                setState(() {
                  titulo = 'Practica 9';
                  indice = 8;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget dinamico() {
    switch (indice) {
      case 0:
        {
          return Container(
            child: Center(
              child: Text('Hola mundo'),
            ),
          );
        }
      default:
        return Container(
          child: Center(
            child: Text('Hola mundo'),
          ),
        );
    }
  }
}
