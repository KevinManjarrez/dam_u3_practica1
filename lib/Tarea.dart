class Tarea {
  int idTarea;
  String idMateria;
  String nombre;
  String fechaEntrega;
  String descripcion;

  Tarea({
    required this.idTarea,
    required this.idMateria,
    required this.nombre,
    required this.fechaEntrega,
    required this.descripcion,
  });

  Map<String, dynamic> toMap() {
    return {
      'idTarea': idTarea,
      'idMateria': idMateria,
      'nombre': nombre,
      'fechaEntrega': fechaEntrega,
      'descripcion': descripcion,
    };
  }
}