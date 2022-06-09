import 'package:aygp_frontend/providers/ui_provider.dart';
import 'package:aygp_frontend/screens/reminders_screen.dart';
import 'package:aygp_frontend/screens/settings_screen.dart';
import 'package:aygp_frontend/screens/sucesos_clave_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_navigation_bar.dart';
import 'diary_screen.dart';
import 'home_screen.dart';

class BaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ayuda y Gestión Psicológica')),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el selectedMenuOpt.
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      // Pantalla de inicio.
      case 0:
        return HomeScreen();

      // Pantalla diario.
      case 1:
        return DiaryScreen();

      // Pantalla sucesos clave.
      case 2:
        return SucesosClaveScreen();

      // Pantalla recordatorios.
      case 3:
        return RemindersScreen();

      // Pantalla ajustes.
      case 4:
        return SettingsScreen();

      // Pantalla por defecto.
      default:
        return HomeScreen();
    }
  }
}
