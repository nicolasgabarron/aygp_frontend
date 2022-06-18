import 'dart:io';

import 'package:aygp_frontend/models/suceso_clave.dart';
import 'package:aygp_frontend/services/suceso_clave_service.dart';
import 'package:aygp_frontend/widgets/suceso_clave/suceso_clave_list_tile.dart';
import 'package:flutter/cupertino.dart';
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

                  Navigator.pushNamed(context, 'sucesoclaveedit');
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Compruebo si la plataforma es IOS.
                        if (Platform.isIOS) {
                          return CupertinoAlertDialog(
                            title: Text('Eliminar suceso'),
                            content: Text(
                                '¿Estás seguro que deseas eliminar este suceso?'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    // Llamo al método del servicio que elimina la entrada.
                                    sucesoClaveService.delete(
                                        sucesoClaveService.sucesosClave[index]);

                                    // Quito el focus de la ventana modal.
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Aceptar',
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ],
                          );
                        } else {
                          return AlertDialog(
                            title: Text('Eliminar entrada'),
                            content: Text(
                                '¿Estás seguro que deseas eliminar esta entrada de diario?'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    // Llamo al método del servicio que elimina la entrada.
                                    sucesoClaveService.delete(
                                        sucesoClaveService.sucesosClave[index]);

                                    // Quito el focus de la ventana modal.
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Aceptar',
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ],
                          );
                        }
                      });
                })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            sucesoClaveService.selectedSuceso = SucesoClave(
                fechaSuceso: DateTime.now(),
                titulo: '',
                contenido: '',
                valoracion: 5);

            Navigator.pushNamed(context, 'sucesoclaveedit');
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }
}
