import 'package:aygp_frontend/providers/recordatorio_form_provider.dart';
import 'package:aygp_frontend/services/recordatorio_service.dart';
import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemindersEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recupero el servicio.
    final recordatorioService = Provider.of<RecordatorioService>(context);

    return ChangeNotifierProvider(
      create: (context) =>
          RecordatorioFormProvider(recordatorioService.selectedRecordatorio),
      child: _RecordatorioEditBody(
        recordatorioService: recordatorioService,
      ),
    );
  }
}

class _RecordatorioEditBody extends StatelessWidget {
  // Recupero el servicio
  final RecordatorioService recordatorioService;

  const _RecordatorioEditBody({Key? key, required this.recordatorioService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordatorioForm = Provider.of<RecordatorioFormProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Recordatorio')),
      body: SingleChildScrollView(child: _RecordatorioForm()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          if (recordatorioForm.isValidForm()) {
            await recordatorioService
                .saveOrCreate(recordatorioForm.recordatorio);
          }
        },
      ),
    );
  }
}

class _RecordatorioForm extends StatelessWidget {
  const _RecordatorioForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Propiedades.
    final recordatorioProvider = Provider.of<RecordatorioFormProvider>(context);
    final recordatorio = recordatorioProvider.recordatorio;

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(),
      width: double.infinity,
      child: Form(
          key: recordatorioProvider.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),

              // Titulo
              Text(
                'Título',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              TextFormField(
                initialValue: recordatorio.titulo,
                onChanged: (value) => recordatorio.titulo = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es obligatorio.';
                  }
                },
                decoration: InputDecorations.formInputDecoration(
                    hintText: 'Introduzca el título del suceso clave'),
              ),
            ],
          )),
    );
  }
}
