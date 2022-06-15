import 'package:aygp_frontend/models/diary_entry.dart';
import 'package:aygp_frontend/services/diary_service.dart';
import 'package:aygp_frontend/widgets/diary/diary_list_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Servicio de Diario.
    final diaryService = Provider.of<DiaryService>(context);

    // Mientras que el estado de la pantalla esté cargando, muestro símbolo de cargando.
    if (diaryService.isLoading) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    // Mientras que no esté cargando (significa que ya ha traido los datos) muestro ListView.
    else {
      return Scaffold(
        body: ListView.builder(
            itemCount: diaryService.diaryEntries.length,
            itemBuilder: (context, index) => GestureDetector(
                  child: DiaryListTile(
                      diaryEntry: diaryService.diaryEntries[index]),
                  onTap: () {
                    diaryService.selectedEntry =
                        diaryService.diaryEntries[index].copy();

                    Navigator.pushNamed(context, 'diaryedit');
                  },
                  onLongPress: () =>
                      null, // TODO: Implementar diálogo de eliminar.
                )),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              diaryService.selectedEntry =
                  DiaryEntry(titulo: '', contenido: '');

              Navigator.pushNamed(context, 'diaryedit');
            },
            child: Icon(Icons.add)),
      );
    }
  }
}
