import 'package:aygp_frontend/providers/ui_provider.dart';
import 'package:aygp_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_navigation_bar.dart';

class BaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: _AdaptiveCustomAppBar(),
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _AdaptiveCustomAppBar extends StatelessWidget {
  const _AdaptiveCustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el selectedMenuOpt.
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return AppBar(
      title: Text(this.getTitleScreen(currentIndex)),
    );
  }

  String getTitleScreen(int index) {
    switch (index) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Diario personal';
      case 2:
        return 'Sucesos clave';
      case 3:
        return 'Recordatorios';
      case 4:
        return 'Ajustes';
      default:
        return '';
    }
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
