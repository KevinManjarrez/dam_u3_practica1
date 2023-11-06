
import 'Materia.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dam_u3_practica1/Tarea.dart';

class DB {
  // En el método _abrirDB
  static Future<Database> _abrirDB() async {
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      join(databasePath, 'MateriasTareas.db'),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE "
            "MATERIA(IDMATERIA TEXT PRIMARY KEY,"
            "NOMBRE TEXT,SEMESTRE TEXT,"
            "DOCENTE TEXT)");

        // Agrega la creación de la tabla "TAREA" con las columnas adecuadas
        await db.execute("CREATE TABLE "
            "TAREA(idTarea INTEGER PRIMARY KEY,"
            "idMateria TEXT,"
            "nombre TEXT,"
            "fechaEntrega TEXT,"
            "descripcion TEXT)");
      },
      version: 1,
    );

    return database;
  }
  //fin crear tabla

  static Future<int> insertar(Materia m) async {
    Database db = await _abrirDB();
    return db.insert("MATERIA", m.toJSON(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  } //fin insertar

  static Future<List<Materia>> mostrarTodos() async {
    Database db = await _abrirDB();
    List<Map<String, dynamic>> resultado = await db.query("MATERIA");
    return List.generate(resultado.length, (index) {
      return Materia(
          idMateria: resultado[index]['IDMATERIA'],
          nombre: resultado[index]['NOMBRE'],
          semestre: resultado[index]['SEMESTRE'],
          docente: resultado[index]['DOCENTE']);
    });
  }

  static Future<int> actualizar(Materia m) async {
    Database db = await _abrirDB();
    return db.update("MATERIA", m.toJSON(),
        where: "IDMATERIA=?", whereArgs: [m.idMateria]);
  }

  static Future<int> eliminar(String idMateria) async {
    Database db = await _abrirDB();
    return db
        .delete("MATERIA", where: "IDMATERIA=?", whereArgs: [idMateria]);
  }

  // Inserta una tarea en la base de datos
  static Future<int> insertarTarea(Tarea tarea) async {
    Database db = await _abrirDB();
    return db.insert("TAREA", tarea.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  // En tu clase DB
  static Future<List<Tarea>> obtenerTareasPorMateria(String idMateria) async {
    Database db = await _abrirDB();
    List<Map<String, dynamic>> resultado = await db.query(
      "TAREA",
      where: "idMateria = ?",
      whereArgs: [idMateria],
    );

    return List.generate(resultado.length, (index) {
      return Tarea(
        idTarea: resultado[index]['idTarea'],
        idMateria: resultado[index]['idMateria'],
        nombre: resultado[index]['nombre'],
        fechaEntrega: resultado[index]['fechaEntrega'],
        descripcion: resultado[index]['descripcion'],
      );
    });
  }

  // Mostrar todas las tareas (solo para depuración)
  static Future<void> mostrarTodasTareas() async {
    Database db = await _abrirDB();
    List<Map<String, dynamic>> resultado = await db.query("TAREA");
    print(resultado);
  }

}