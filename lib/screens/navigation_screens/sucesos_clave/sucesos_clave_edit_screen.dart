import 'package:aygp_frontend/models/suceso_clave.dart';
import 'package:aygp_frontend/providers/suceso_clave_form_provider.dart';
import 'package:aygp_frontend/services/suceso_clave_service.dart';
import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SucesosClaveEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recupero el Servicio.
    final sucesoClaveService = Provider.of<SucesoClaveService>(context);

    return ChangeNotifierProvider(
      create: (context) =>
          SucesoClaveFormProvider(sucesoClaveService.selectedSuceso),
      child: _SucesoClaveEditBody(sucesoClaveService: sucesoClaveService),
    );
  }
}

class _SucesoClaveEditBody extends StatelessWidget {
  // Recupero el Servicio.
  final SucesoClaveService sucesoClaveService;

  const _SucesoClaveEditBody({
    Key? key,
    required this.sucesoClaveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Recupero el FromProvider.
    final sucesoClaveForm = Provider.of<SucesoClaveFormProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Suceso Clave')),
      body: SingleChildScrollView(child: _SucesoClaveForm()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          if (sucesoClaveForm.isValidForm()) {
            await sucesoClaveService.saveOrCreate(sucesoClaveForm.sucesoClave);
          }
        },
      ),
    );
  }
}

class _SucesoClaveForm extends StatefulWidget {
  const _SucesoClaveForm({Key? key}) : super(key: key);

  @override
  State<_SucesoClaveForm> createState() => _SucesoClaveFormState();
}

class _SucesoClaveFormState extends State<_SucesoClaveForm> {
  @override
  Widget build(BuildContext context) {
    // Propiedades
    final sucesoClaveForm = Provider.of<SucesoClaveFormProvider>(context);
    final sucesoClave = sucesoClaveForm.sucesoClave;
    final TextEditingController _controller = TextEditingController();

    _controller.text =
        DateFormat('dd-MM-yyyy // hh:mm').format(sucesoClave.fechaSuceso);

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(),
      width: double.infinity,
      child: Form(
          key: sucesoClaveForm.formKey,
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
                initialValue: sucesoClave.titulo,
                onChanged: (value) => sucesoClave.titulo = value,
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

              Text(
                'Fecha y hora del suceso',
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
                    sucesoClave.fechaSuceso = fechaSeleccionada;

                    _controller.text = DateFormat('dd-MM-yyyy || HH:mm')
                        .format(sucesoClave.fechaSuceso);

                    setState(() {});
                  });
                },
              ),

              SizedBox(
                height: 25,
              ),

              // Valoración del suceso
              Text(
                'Valoración del suceso',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),

              Slider.adaptive(
                  min: 0,
                  max: 10,
                  divisions: 4,
                  value: sucesoClave.valoracion,
                  onChanged: (double newValue) {
                    sucesoClave.valoracion = newValue;

                    setState(() {});
                  }),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getEmojiValoracion(sucesoClave),
                        style: TextStyle(fontSize: 25),
                      ),
                    ]),
              ),

              SizedBox(
                height: 25,
              ),

              // Contenido del Suceso.
              Text(
                'Descripción',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),

              TextFormField(
                initialValue: sucesoClave.contenido,
                maxLines: 12,
                onChanged: (value) => sucesoClave.contenido = value,
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

  // No se utiliza un Switch porque no funciona con doubles.
  String getEmojiValoracion(SucesoClave sucesoClave) {
    if (sucesoClave.valoracion == 0)
      return '😭 - Horrible';
    else if (sucesoClave.valoracion == 2.5)
      return '😓 - Muy mal';
    else if (sucesoClave.valoracion == 5)
      return '😕 - Normal';
    else if (sucesoClave.valoracion == 7.5)
      return '😄 - Bien';
    else if (sucesoClave.valoracion == 10) return '😊 - Muy bien';

    return '';
  }
}
