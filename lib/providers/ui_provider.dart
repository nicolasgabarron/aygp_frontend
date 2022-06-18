import 'package:flutter/material.dart';

// Provider que se utilizará en la BottomNavigationBar para saber qué opción
// está seleccionada y así mostrar un contenido u otro.
// También se utiliza en el AppBar dinámico para cambiar el título.
class UiProvider extends ChangeNotifier {
  // Propiedades.
  int _selectedMenuOpt = 0;

  // Getters y setters.
  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int value) {
    this._selectedMenuOpt = value;
    notifyListeners(); // Notifico a los widgets que escuchan cambios de esta propiedad.
  }
}
