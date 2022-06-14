import 'package:aygp_frontend/screens/screens.dart';
import 'package:aygp_frontend/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Propiedades.
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return const CircularProgressIndicator.adaptive();

            // Si la data es un string vacio, significa que no hay JWT y por tanto,
            // se debe redirigir a la pantalla de Login.
            if (snapshot.data == '') {
              Future.microtask(() => Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LoginScreen(),
                  )));
            } else {
              Future.microtask(() => Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BaseScreen(),
                  )));
            }

            // En principio, es inalcanzable.
            return Container();
          },
        ),
      ),
    );
  }
}
