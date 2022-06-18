import 'package:aygp_frontend/providers/recordatorio_form_provider.dart';
import 'package:aygp_frontend/services/recordatorio_service.dart';
import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
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

class _RecordatorioForm extends StatefulWidget {
  const _RecordatorioForm({Key? key}) : super(key: key);

  @override
  State<_RecordatorioForm> createState() => _RecordatorioFormState();
}

class _RecordatorioFormState extends State<_RecordatorioForm> {
  @override
  Widget build(BuildContext context) {
    // Propiedades.
    final recordatorioProvider = Provider.of<RecordatorioFormProvider>(context);
    final recordatorio = recordatorioProvider.recordatorio;
    final TextEditingController _controller = TextEditingController();

    _controller.text = DateFormat('dd-MM-yyyy // hh:mm')
        .format(recordatorio.fechaRecordatorio);

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

              SizedBox(
                height: 25,
              ),

              // Fecha del recordatorio
              Text(
                'Fecha del recordatorio',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),

              TextFormField(
                controller: _controller,
                readOnly: true,
                decoration: InputDecorations.formInputDecoration(
                    hintText: 'Fecha y hora del suceso'),
                onTap: () {
                  DatePicker.showDateTimePicker(context, showTitleActions: true,
                      onConfirm: (fechaSeleccionada) {
                    recordatorio.fechaRecordatorio = fechaSeleccionada;

                    _controller.text = DateFormat('dd-MM-yyyy || HH:mm')
                        .format(recordatorio.fechaRecordatorio);

                    setState(() {});
                  });
                },
              ),

              SizedBox(
                height: 25,
              ),

              // Contenido
              Text(
                'Fecha del recordatorio',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),

              TextFormField(
                initialValue: recordatorio.detalle,
                maxLines: 10,
                onChanged: (value) => recordatorio.detalle = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El detalle es obligatorio.';
                  }
                },
                decoration: InputDecorations.formInputDecoration(
                    hintText: 'Introduzca el contenido del recordatorio'),
              ),

              SizedBox(
                height: 25,
              ),

              // Realizado
              SwitchListTile.adaptive(
                  title: Text(
                    'Realizado',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  value: recordatorio.realizado,
                  onChanged: (newValue) {
                    recordatorio.realizado = newValue;

                    setState(() {});
                  })
            ],
          )),
    );
  }
}
