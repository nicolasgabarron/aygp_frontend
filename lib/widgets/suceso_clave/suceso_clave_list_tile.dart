import 'package:aygp_frontend/models/suceso_clave.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SucesoClaveListTile extends StatelessWidget {
  // Propiedades.
  final SucesoClave sucesoClave;

  const SucesoClaveListTile({Key? key, required this.sucesoClave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transformo la fecha para poder utilizarla.
    final String fechaEntrada =
        DateFormat('dd-MM-yyyy').format(this.sucesoClave.fechaCreacion!);

    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.announcement_rounded,
          // TODO: Añadir color?
        ),
        title: Text(sucesoClave.titulo),
        subtitle: Text(
            'Fecha: $fechaEntrada - Valoración: ${sucesoClave.valoracion}'),
      ),
    );
  }
}
