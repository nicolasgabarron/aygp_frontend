import 'package:flutter/material.dart';

class InputDecorations {
  // Método para establecer apariencia de los inputs de la ventana de autenticación.
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.purple,
        ),
        prefixIcon: prefixIcon!= null
            ? Icon(prefixIcon, color: Colors.deepPurple,)
            : null
    );
  }
}
