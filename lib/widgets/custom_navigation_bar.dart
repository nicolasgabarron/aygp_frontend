import 'package:aygp_frontend/providers/ui_provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Traigo el provider que gestiona la opción seleccionada.
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => uiProvider.selectedMenuOpt = index,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          // ITEM INICIO.
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),

          // ITEM DIARIO.
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diario'),

          // ITEM SUCESOS CLAVE.
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement_rounded), label: 'Sucesos clave'),

          // ITEM RECORDATORIOS.
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Recordatorios'),

          // ITEM AJUSTES.
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ]);
  }
}
