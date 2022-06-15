import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:flutter/material.dart';

class DiaryEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
