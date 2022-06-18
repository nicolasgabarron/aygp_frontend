import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/recordatorio.dart';

class RecordatorioListTile extends StatelessWidget {
  // Propiedades.
  final Recordatorio recordatorio;

  const RecordatorioListTile({Key? key, required this.recordatorio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transformo la fecha para poder utilizarla.
    final String fechaCreacionText =
        DateFormat('dd-MM-yyyy').format(recordatorio.fechaCreacion!);
    final String fechaVencimientoText =
        DateFormat('dd-MM-yyyy - hh:mm').format(recordatorio.fechaRecordatorio);

    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text(recordatorio.titulo),
        subtitle: Text(
            'Fecha creación: $fechaCreacionText | Fecha vencimiento: $fechaVencimientoText'),
      ),
    );
  }
}
