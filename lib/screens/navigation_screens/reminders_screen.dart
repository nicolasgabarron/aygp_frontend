import 'dart:io';

import 'package:aygp_frontend/models/recordatorio.dart';
import 'package:aygp_frontend/services/diary_service.dart';
import 'package:aygp_frontend/services/recordatorio_service.dart';
import 'package:aygp_frontend/widgets/recordatorio/recordatorio_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Servicio de recordatorios.
    final recordatorioService = Provider.of<RecordatorioService>(context);

    if (recordatorioService.isLoading) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else {
      return Scaffold(
        body: ListView.builder(
            itemCount: recordatorioService.recordatorios.length,
            itemBuilder: (context, index) => GestureDetector(
                child: RecordatorioListTile(
                    recordatorio: recordatorioService.recordatorios[index]),
                onTap: () {
                  recordatorioService.selectedRecordatorio =
                      recordatorioService.recordatorios[index];

                  // TODO: Implementar navigator.
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Compruebo si la plataforma es IOS.
                        if (Platform.isIOS) {
                          return CupertinoAlertDialog(
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
                                    recordatorioService.delete(
                                        recordatorioService
                                            .recordatorios[index]);

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
                                    recordatorioService.delete(
                                        recordatorioService
                                            .recordatorios[index]);

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
            recordatorioService.selectedRecordatorio = Recordatorio(
                titulo: '',
                detalle: '',
                fechaRecordatorio: DateTime.now(),
                realizado: false);

            // TODO: Implementar navigator.
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }
}
