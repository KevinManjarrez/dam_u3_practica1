class Tarea {
  final int? id;
  final int materiaId;
  final String nombre;
  final String fechaVencimiento;
  final int completada;

  Tarea({
    this.id,
    required this.materiaId,
    required this.nombre,
    required this.fechaVencimiento,
    required this.completada,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'materiaId': materiaId,
      'nombre': nombre,
      'fechaVencimiento': fechaVencimiento,
      'completada': completada,
    };
  }

  @override
  String toString() {
    return 'Tarea{id: $id, materiaId: $materiaId, nombre: $nombre, fechaVencimiento: $fechaVencimiento, completada: $completada}';
  }
}