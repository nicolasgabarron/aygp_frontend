import 'package:flutter/material.dart';

// Provider que utilizamos en la pantalla de ajustes para establecer el
// TEMA de la aplicación de una forma global, utilizando también las
// SharedPreferences.
class ThemeProvider extends ChangeNotifier {
  // Propiedades.
  ThemeData currentTheme;

  // Constructor que define la propiedad "currentTheme" en la hora de la llamada.
  ThemeProvider({required bool isDarkMode})
      : currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();

  // Método que define el tema a CLARO.
  // Notifica a los widgets que están a la escucha de cambios.
  setLightMode() {
    currentTheme = ThemeData.light();
    notifyListeners();
  }

  // Método que define el tema a OSCURO.
  // Notifica a los widgets que están a la escucha de cambios.
  setDarkMode() {
    currentTheme = ThemeData.dark();
    notifyListeners();
  }
}
