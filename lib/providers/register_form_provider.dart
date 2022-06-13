import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String username = '';
  String password = '';
  DateTime fechaNacimiento = DateTime(2022);
  String nombre = '';
  String apellidos = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
