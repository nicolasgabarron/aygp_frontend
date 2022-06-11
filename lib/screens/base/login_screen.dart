import 'package:aygp_frontend/providers/login_form_provider.dart';
import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:aygp_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Center: Centrará todos los elementos en la pantalla.
      body: Center(
        // Fondo superior de la pantalla (creado a mano).
        child: AuthBackground(
            // SingleChildScrollView: en caso de que se quede sin espacio (como
            // cuando muestra el teclado, que permita el scroll).
            child: SingleChildScrollView(
          // Column: Contiene el formulario.
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
                      '¡Bienvenido!',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // Formulario.
                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),

              // Botón de REGISTRO.
              SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'register'),
                  child: Text('Crear una nueva cuenta')),

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

// Formulario de login.
class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
          // Valida a cada interacción del usuario.
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              // Campo EMAIL.
              TextFormField(
                autocorrect: false,

                keyboardType: TextInputType.emailAddress,

                // Apariencia modularizada en clase InputDecorations.
                // TODO: Revisar por qué en modo oscuro no se visualiza correctamente.
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'correo@dominio.com',
                    labelText: 'Correo Electrónico',
                    prefixIcon: Icons.alternate_email),

                // Validación del campo.
                // Utiliza REGEX.
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El correo no es válido.';
                },
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
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Debe introducir una contraseña.';
                  }
                },
              ),

              SizedBox(
                height: 25,
              ),

              // Botón de ENTRAR.
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                color: Colors.blue[800],
                child: Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // Oculto el teclado.
                  FocusScope.of(context).unfocus();

                  // Si el formulario es válido...
                  if (loginForm.isValidForm()) {
                    Navigator.pushReplacementNamed(context, 'base');
                  }
                },
              )
            ],
          )),
    );
  }
}
