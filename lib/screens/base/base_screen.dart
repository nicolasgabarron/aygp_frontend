import 'package:aygp_frontend/providers/ui_provider.dart';
import 'package:aygp_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_navigation_bar.dart';

// Pantalla principal de la aplicación.
// Se navega a esta pantalla en caso de que el login sea satisfactorio.
class BaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PreferredSize: se necesita este widget para admitir el cambio dinámico de la barra.
      appBar: PreferredSize(
        // Tamaño del AppBar.
        // Todo el ancho x la altura por defecto de las AppBar.
        preferredSize: const Size(double.infinity, kToolbarHeight),

        // AppBar dinámico.
        child: _AdaptiveCustomAppBar(),
      ),

      // Cuerpo de la pantalla. Cambia dinámicamente ya que este devuelve
      // un widget. Este widget cambia en función del índice seleccionado.
      body: _HomePageBody(),

      // BottomNavigationBar que contiene el enrutamiento a todas las páginas.
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

// CustomAppBar en entorno privado ya que el único que la va a utilizar
// es esta clase Dart.
// Consiste en un appbar que en función de la opción seleccionada en el
// BottomNavigationBar muestra un título u otro.
class _AdaptiveCustomAppBar extends StatelessWidget {
  const _AdaptiveCustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el selectedMenuOpt del BottomNavigationBar.
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    // Devuelve AppBar con el título establecido de forma dinámica.
    return AppBar(
      title: Text(this.getTitleScreen(currentIndex)),
    );
  }

  // Método que devuelve el título que corresponde a cada índice del
  // BottomNavigationBar.
  String getTitleScreen(int index) {
    switch (index) {
      case 0: // INDICE 0 - Pantalla de Inicio.
        return 'Inicio';
      case 1: // INDICE 1 - Pantalla de Diario.
        return 'Diario personal';
      case 2: // INDICE 2 - Pantalla de Sucesos Clave.
        return 'Sucesos clave';
      case 3: // INDICE 3 - Pantalla de Recordatorios.
        return 'Recordatorios';
      case 4: // INDICE 4 - Pantalla de Ajustes.
        return 'Ajustes';
      default: // Caso por defecto. En principio, es inalcanzable.
        return '';
    }
  }
}

// Widget que se encarga de devolver propiamente las demas pantallas en función
// al índice que nos devuelve el Provider que utiliza la BottomNavigationBar.
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
