import 'package:aygp_frontend/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ayuda y Gestión Psicológica')),
      body: Center(
        child: Text('Home Screen'),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
