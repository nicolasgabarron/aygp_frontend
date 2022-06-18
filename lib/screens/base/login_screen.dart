import 'package:aygp_frontend/providers/login_form_provider.dart';
import 'package:aygp_frontend/services/auth_service.dart';
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

              SizedBox(
                height: 40,
              ),

              // Botón de REGISTRO.
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'register'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.blue[80]),
                      shape: MaterialStateProperty.all(StadiumBorder())),
                  child: Text(
                    'Crear una nueva cuenta',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),

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
              // Campo USERNAME.
              TextFormField(
                autocorrect: false,

                keyboardType: TextInputType.text,

                // Apariencia modularizada en clase InputDecorations.
                // TODO: Revisar por qué en modo oscuro no se visualiza correctamente.
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'nombreusuario',
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icons.person),

                // Sincronizo el valor del campo en el provider.
                onChanged: (value) => loginForm.username = value,
                // Validación del campo.
                validator: (value) {
                  if (value != null && value.length < 3) {
                    return 'El nombre de usuario debe tener al menos 3 caracteres.';
                  }
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
                onChanged: (value) => loginForm.password = value,
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
                    // Obtengo el Servicio de autenticación.
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    // Recupero la respuesta de ejecutar el LOGIN.
                    final String? jwt = await authService.loginUser(
                        loginForm.username, loginForm.password);

                    // Si es diferente a error (mensaje establecido en AuthService. Posteriormente cambiará)...
                    if (jwt != 'error') {
                      print(jwt);

                      Navigator.pushReplacementNamed(context, 'base');
                    } else {
                      // Lanzar MENSAJE DE ERROR VISUAL.
                    }
                  }
                },
              )
            ],
          )),
    );
  }
}
