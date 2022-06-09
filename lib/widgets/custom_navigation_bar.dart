import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner), label: 'Diario'),
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement_rounded), label: 'Sucesos clave'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Recordatorios'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ]);
  }
}
