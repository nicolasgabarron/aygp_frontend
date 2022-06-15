import 'dart:convert';

class DiaryEntry {
  DiaryEntry({
    required this.id,
    required this.usuarioId,
    required this.titulo,
    required this.fechaCreacion,
    required this.contenido,
  });

  int id;
  int usuarioId;
  String titulo;
  DateTime fechaCreacion;
  String contenido;

  factory DiaryEntry.fromJson(String str) =>
      DiaryEntry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiaryEntry.fromMap(Map<String, dynamic> json) => DiaryEntry(
        id: json["id"],
        usuarioId: json["usuarioId"],
        titulo: json["titulo"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        contenido: json["contenido"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "usuarioId": usuarioId,
        "titulo": titulo,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "contenido": contenido,
      };
}
