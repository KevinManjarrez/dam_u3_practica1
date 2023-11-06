import 'Materia.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _abrirDB() async {
    return openDatabase(join(await getDatabasesPath(), 'MateriasTareas.db'),
        onCreate: (db, version) {
          return db.execute("CREATE TABLE "
              "MATERIA(IDMATERIA TEXT PRIMARY KEY,"
              "NOMBRE TEXT,SEMESTRE TEXT,"
              "DOCENTE TEXT)");
        }, version: 1);
  } //fin crear tabla

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
}
