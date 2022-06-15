import 'package:flutter/material.dart';

class InputDecorations {
  // Método para establecer apariencia de los inputs de la ventana de autenticación.
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[800]!)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[800]!, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.blue[800],
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.blue[800],
              )
            : null);
  }

  static InputDecoration formInputDecoration(
      {required String hintText, String? labelText, IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[800]!)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[800]!, width: 2)),
        hintText: hintText,
        labelText: labelText ?? null,
        labelStyle: TextStyle(color: Colors.blue[800], fontSize: 17),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.blue[800],
              )
            : null);
  }
}
