import 'package:aygp_frontend/models/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryListTile extends StatelessWidget {
  // Propiedades.
  final DiaryEntry diaryEntry;

  const DiaryListTile({Key? key, required this.diaryEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transformo la fecha para poder utilizarla.
    final String fechaEntrada =
        DateFormat('dd-MM-yyyy').format(this.diaryEntry.fechaCreacion);

    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.book,
          // TODO: Añadir color?
        ),
        title: Text(diaryEntry.titulo),
        subtitle: Text('Fecha: $fechaEntrada'),
        onTap: () => Navigator.pushNamed(context, 'diaryedit'),
      ),
    );
  }
}
