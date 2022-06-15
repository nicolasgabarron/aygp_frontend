import 'package:aygp_frontend/providers/diary_form_provider.dart';
import 'package:aygp_frontend/services/diary_service.dart';
import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiaryEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recupero el DiaryService.
    final diaryService = Provider.of<DiaryService>(context);

    return ChangeNotifierProvider(
        create: (context) => DiaryFormProvider(diaryService.selectedEntry),
        child: _DiaryEditBody(
          diaryService: diaryService,
        ));
  }
}

class _DiaryEditBody extends StatelessWidget {
  // Recupero el DiaryService.
  final diaryService;

  const _DiaryEditBody({
    Key? key,
    required this.diaryService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final diaryForm = Provider.of<DiaryFormProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Entrada de Diario')),
      body: SingleChildScrollView(child: _DiaryForm()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          // TODO: Guardar o modificar entrada de diario.
        },
      ),
    );
  }
}

class _DiaryForm extends StatelessWidget {
  const _DiaryForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Propiedades.
    final diaryProvider = Provider.of<DiaryFormProvider>(context);
    final diaryEntry = diaryProvider.diaryEntry;

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(),
      width: double.infinity,
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),

          // Header Título
          Text(
            'Título',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),

          // TITULO
          TextFormField(
            initialValue: diaryEntry.titulo,
            onChanged: (value) => diaryEntry.titulo = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El título es obligatorio.';
              }
            },
            decoration: InputDecorations.formInputDecoration(
                hintText: 'Introduzca el título que quiere dar a la entrada'),
          ),

          SizedBox(
            height: 25,
          ),

          // Header Contenido.
          Text(
            'Contenido',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),

          // CONTENIDO.
          TextFormField(
            initialValue: diaryEntry.contenido,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 10,
            decoration: InputDecorations.formInputDecoration(
                hintText:
                    'Escriba aquí el contenido de la entrada de diario...'),
          )
        ],
      )),
    );
  }
}
