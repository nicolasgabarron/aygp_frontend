// To parse this JSON data, do
//
//     final sucesoClave = sucesoClaveFromMap(jsonString);

import 'dart:convert';

class SucesoClave {
  SucesoClave({
    this.id,
    this.usuarioId,
    this.fechaCreacion,
    required this.fechaSuceso,
    required this.titulo,
    required this.contenido,
    required this.valoracion,
  });

  int? id;
  int? usuarioId;
  DateTime? fechaCreacion;
  DateTime fechaSuceso;
  String titulo;
  String contenido;
  int valoracion;

  factory SucesoClave.fromJson(String str) =>
      SucesoClave.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SucesoClave.fromMap(Map<String, dynamic> json) => SucesoClave(
        id: json["id"],
        usuarioId: json["usuarioId"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaSuceso: DateTime.parse(json["fechaSuceso"]),
        titulo: json["titulo"],
        contenido: json["contenido"],
        valoracion: json["valoracion"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "usuarioId": usuarioId,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaSuceso": fechaSuceso.toIso8601String(),
        "titulo": titulo,
        "contenido": contenido,
        "valoracion": valoracion,
      };

  SucesoClave copy() {
    return SucesoClave(
        fechaSuceso: this.fechaSuceso,
        titulo: this.titulo,
        contenido: this.contenido,
        valoracion: this.valoracion);
  }
}
