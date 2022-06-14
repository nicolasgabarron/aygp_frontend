import 'package:aygp_frontend/providers/theme_provider.dart';
import 'package:aygp_frontend/providers/ui_provider.dart';
import 'package:aygp_frontend/screens/screens.dart';
import 'package:aygp_frontend/services/auth_service.dart';
import 'package:aygp_frontend/services/notifications_service.dart';
import 'package:aygp_frontend/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializo las SharedPreferences.
  await Preferences.init();

  runApp(
      // Utilizo MultiProvider ya que necesito utilizar un Provider globalizado,
      // el cual gestiona el tema.
      MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(isDarkMode: Preferences.isDarkMode),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => new UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => new AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ayuda y Gestión Psicológica',
        initialRoute: 'checkjwt',
        scaffoldMessengerKey: NotificationsService.messengerKey,
        routes: {
          'checkjwt': (context) => CheckAuthScreen(),
          'login': (context) => LoginScreen(),
          'register': (context) => RegisterScreen(),
          'base': (context) => BaseScreen(),
        },
        theme: Provider.of<ThemeProvider>(context).currentTheme,
      ),
    );
  }
}
