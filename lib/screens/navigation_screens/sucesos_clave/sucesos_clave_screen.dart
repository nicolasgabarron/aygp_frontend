import 'package:aygp_frontend/models/suceso_clave.dart';
import 'package:aygp_frontend/services/suceso_clave_service.dart';
import 'package:aygp_frontend/widgets/suceso_clave/suceso_clave_list_tile.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SucesosClaveScreen extends StatelessWidget {
  const SucesosClaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Servicio de SucesoClave
    final sucesoClaveService = Provider.of<SucesoClaveService>(context);

    // Mientras que el estado de la pantalla esté cargando, muestro símbolo de carga.
    if (sucesoClaveService.isLoading) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    // Mientras no esté cargando (significa que ya ha traido todos los datos) muestro el Listview.
    else {
      return Scaffold(
        body: ListView.builder(
          itemCount: sucesoClaveService.sucesosClave.length,
          itemBuilder: (context, index) => GestureDetector(
            child: SucesoClaveListTile(
                sucesoClave: sucesoClaveService.sucesosClave[index]),
            onTap: () {
              sucesoClaveService.selectedSuceso =
                  sucesoClaveService.sucesosClave[index].copy();

              // TODO: Implementar Navigator.
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            sucesoClaveService.selectedSuceso = SucesoClave(
                fechaSuceso: DateTime.now(),
                titulo: '',
                contenido: '',
                valoracion: 5);

            // TODO: Añadir el navigator.
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }
}
