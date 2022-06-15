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
        children: [
          SizedBox(
            height: 10,
          ),

          // TITULO
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Introduzca el título que quiere dar a la entrada',
                labelText: 'Título'),
          ),

          SizedBox(
            height: 25,
          ),

          // CONTENIDO.
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecorations.authInputDecoration(
                hintText:
                    'Escriba aquí el contenido de la entrada de diario...',
                labelText: 'Contenido'),
          )
        ],
      )),
    );
  }
}
