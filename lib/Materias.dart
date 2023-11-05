import 'package:flutter/material.dart';

class Materias extends StatefulWidget {
  const Materias({super.key});

  @override
  State<Materias> createState() => _MateriasState();
}

class _MateriasState extends State<Materias> {
  int indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Materias'),
        ),
        body: dinamico(),
    );
  }

  Widget dimamico() {
    switch (indice) {
      case 0:
        {
          return Text('Hola mundo');
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
}