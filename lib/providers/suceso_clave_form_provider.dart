import 'package:aygp_frontend/models/suceso_clave.dart';
import 'package:flutter/material.dart';

class SucesoClaveFormProvider extends ChangeNotifier {
  // Propiedades.
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  SucesoClave sucesoClave;

  SucesoClaveFormProvider(this.sucesoClave);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
