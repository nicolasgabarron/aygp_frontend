// To parse this JSON data, do
//
//     final recordatorio = recordatorioFromMap(jsonString);

import 'dart:convert';

class Recordatorio {
  Recordatorio({
    this.id,
    this.usuarioId,
    required this.titulo,
    required this.detalle,
    this.fechaCreacion,
    required this.fechaRecordatorio,
    required this.realizado,
  });

  int? id;
  int? usuarioId;
  String titulo;
  String detalle;
  DateTime? fechaCreacion;
  DateTime fechaRecordatorio;
  bool realizado;

  factory Recordatorio.fromJson(String str) =>
      Recordatorio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Recordatorio.fromMap(Map<String, dynamic> json) => Recordatorio(
        id: json["id"],
        usuarioId: json["usuarioId"],
        titulo: json["titulo"],
        detalle: json["detalle"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaRecordatorio: DateTime.parse(json["fechaRecordatorio"]),
        realizado: json["realizado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "usuarioId": usuarioId,
        "titulo": titulo,
        "detalle": detalle,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaRecordatorio": fechaRecordatorio.toIso8601String(),
        "realizado": realizado,
      };
}
