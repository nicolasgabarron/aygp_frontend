import 'package:aygp_frontend/providers/ui_provider.dart';
import 'package:aygp_frontend/screens/screens.dart';
import 'package:aygp_frontend/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializo las SharedPreferences.
  await Preferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => new UiProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ayuda y Gestión Psicológica',
        initialRoute: 'login',
        routes: {
          'login': (context) => LoginScreen(),
          'base': (context) => BaseScreen(),
        },
      ),
    );
  }
}
