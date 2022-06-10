import 'package:aygp_frontend/providers/theme_provider.dart';
import 'package:aygp_frontend/share_preferences/preferences.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        SwitchListTile.adaptive(
            value: Preferences.isDarkMode,
            title: const Text('Modo oscuro'),
            onChanged: (value) {
              Preferences.isDarkMode = value;

              final themeProvider =
                  Provider.of<ThemeProvider>(context, listen: false);

              if (value)
                themeProvider.setDarkMode();
              else
                themeProvider.setLightMode();

              setState(() {});
            })
      ],
    );
  }
}
