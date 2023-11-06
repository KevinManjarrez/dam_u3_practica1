class Tarea {
  int? idTarea;
  String idMateria;
  String nombre;
  String fechaEntrega;
  String descripcion;

  Tarea({
    this.idTarea,
    required this.idMateria,
    required this.nombre,
    required this.fechaEntrega,
    required this.descripcion,
  });

  Map<String, dynamic> toJSON() {
    return {
      'idMateria': idMateria,
      'nombre': nombre,
      'fechaEntrega': fechaEntrega,
      'descripcion': descripcion,
    };
  }
}