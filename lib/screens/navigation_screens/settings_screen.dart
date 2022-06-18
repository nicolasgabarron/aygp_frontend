import 'package:aygp_frontend/providers/theme_provider.dart';
import 'package:aygp_frontend/services/auth_service.dart';
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
            }),

        // Separador (empuja el botón al final de la pantalla).
        Expanded(
          child: Container(),
        ),

        Text('Aplicación desarrollada por Nicolás Gabarrón Blaya'),

        // BOTON Cerrar sesión.
        TextButton(
            onPressed: () async {
              final authService =
                  Provider.of<AuthService>(context, listen: false);

              final bool? logoutResponse = await authService.logoutUser();

              if (logoutResponse == true) {
                // TODO: Lanzar notificación de logout satisfactorio.

                // Navego a la pantalla de login.
                Navigator.pushReplacementNamed(context, 'login');
              }
            },
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.blue[80]),
                shape: MaterialStateProperty.all(StadiumBorder())),
            child: Text(
              'Cerrar sesión',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),

        // SizedBox para separar el botón del final de la pantalla.
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
