import 'package:aygp_frontend/models/recordatorio.dart';
import 'package:flutter/material.dart';

class RecordatorioFormProvider extends ChangeNotifier {
  // Propiedades.
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Recordatorio recordatorio;

  RecordatorioFormProvider(this.recordatorio);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
