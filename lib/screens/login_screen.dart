import 'package:aygp_frontend/providers/login_form_provider.dart';
import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:aygp_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                // Validación del campo.
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
                  if(value!= null && value.isEmpty) {
                    return 'Debe introducir una contraseña.';
                  }
                },
              ),

              SizedBox(
                height: 25,
              ),

              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                color: Colors.deepPurple,
                child: Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // Oculto el teclado.
                  FocusScope.of(context).unfocus();

                  // Si el formulario es válido...
                  if(loginForm.isValidForm()){
                    Navigator.pushReplacementNamed(context, 'home');
                  }

                },
              )
            ],
          )),
    );
  }
}