import 'package:aygp_frontend/providers/theme_provider.dart';
import 'package:aygp_frontend/share_preferences/preferences.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pantalla de ajustes. Precisa extender de StatefulWidget para poder
// redibujar en tiempo de ejecución (cuando se hace click en algún control)
// la propia pantalla.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Botón de selección del tema oscuro.
        SwitchListTile.adaptive(
            // Utilizo clase "global" que hace uso de las SharedPreferences.
            value: Preferences.isDarkMode,
            title: const Text('Modo oscuro'),
            onChanged: (value) {
              // Defino la propiedad dentro de la clase globalizada que hace uso
              // de las SharedPreferences.
              Preferences.isDarkMode = value;

              // Obtengo el ThemeProvider para así definirlo y notificar cambio
              // al Main (para que redibuje toda la aplicación).
              final themeProvider =
                  Provider.of<ThemeProvider>(context, listen: false);

              // Valoro el nuevo valor que toma el switch.
              if (value)
                themeProvider.setDarkMode();
              else
                themeProvider.setLightMode();

              // Redibujo la pantalla local.
              setState(() {});
            })
      ],
    );
  }
}
