import 'package:aygp_frontend/screens/screens.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayuda y Gestión Psicológica',
      initialRoute: 'home',
      routes: {
        'login': (context) => LoginScreen(),
        'home': (context) => HomeScreen(),
      },
    );
  }
}
