import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
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
