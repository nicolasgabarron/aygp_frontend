import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:aygp_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AuthBackground(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
              ),
              CardContainer(
                // Columna que contendrá el propio formulario.
                child: Column(
                  children: [
                    // Título.
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Bienvenido!',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // Formulario.
                    _LoginForm()
                  ],
                ),
              ),

              // Botón de REGISTRO.
              SizedBox(
                height: 40,
              ),
              Text('Crear nueva cuenta'),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          // TODO: Mantener la referencia al key.
          child: Column(
        children: [
          // Campo EMAIL.
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            // Apariencia modularizada en clase InputDecorations.
            decoration: InputDecorations.authInputDecoration(
                hintText: 'correo@dominio.com',
                labelText: 'Correo Electrónico',
                prefixIcon: Icons.alternate_email),
          ),

          SizedBox(
            height: 15,
          ),

          // Campo CONTRASEÑA
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Contaseña',
                labelText: 'Contraseña',
                prefixIcon: Icons.password),
          ),

          SizedBox(
            height: 25,
          ),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.deepPurple,
            child: Text('Entrar', style: TextStyle(color: Colors.white),),
            onPressed: () {
              // TODO Lanzar petición contra REST.
            },
          )
        ],
      )),
    );
  }
}
