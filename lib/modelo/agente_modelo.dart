class Agente {
  final String uuid;
  final String nombre;
  final String descripcion;
  final String icono;

  Agente({required this.uuid, required this.nombre, required this.descripcion, required this.icono});

  factory Agente.fromJson(Map<String, dynamic> json) {
    return Agente(
      uuid: json['uuid'],
      nombre: json['displayName'],
      descripcion: json['description'],
      icono:json['displayIcon'],
    );
  }

}
