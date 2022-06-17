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
  String? fechaCreacion;
  String fechaSuceso;
  String titulo;
  String contenido;
  int valoracion;

  factory SucesoClave.fromJson(String str) =>
      SucesoClave.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SucesoClave.fromMap(Map<String, dynamic> json) => SucesoClave(
        id: json["id"],
        usuarioId: json["usuarioId"],
        fechaCreacion: json["fechaCreacion"],
        fechaSuceso: json["fechaSuceso"],
        titulo: json["titulo"],
        contenido: json["contenido"],
        valoracion: json["valoracion"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "usuarioId": usuarioId,
        "fechaCreacion": fechaCreacion,
        "fechaSuceso": fechaSuceso,
        "titulo": titulo,
        "contenido": contenido,
        "valoracion": valoracion,
      };
}
