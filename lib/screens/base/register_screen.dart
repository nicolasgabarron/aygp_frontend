import 'package:aygp_frontend/providers/login_form_provider.dart';
import 'package:aygp_frontend/providers/register_form_provider.dart';
import 'package:aygp_frontend/ui/input_decorations.dart';
import 'package:aygp_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
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
                      'Crear una nueva cuenta',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // Formulario.
                    ChangeNotifierProvider(
                      create: (context) => RegisterFormProvider(),
                      child: _RegisterForm(),
                    ),
                  ],
                ),
              ),

              // Botón de REGISTRO.
              SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.blue[80]),
                      shape: MaterialStateProperty.all(StadiumBorder())),
                  child: Text(
                    'Ya soy usuario',
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
class _RegisterForm extends StatefulWidget {
  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  // Propiedades.
  TextEditingController datecontroller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    datecontroller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
          key: registerForm.formKey,
          // Valida a cada interacción del usuario.
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              // Campo NOMBRE.
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Introduzca su nombre',
                    labelText: 'Nombre',
                    prefixIcon: Icons.person),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Debes introducir el nombre.';
                  } else if (value!.length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres.';
                  }
                },
              ),

              SizedBox(
                height: 10,
              ),

              // Campo APELLIDOS
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Introduzca sus apellidos',
                    labelText: 'Apellidos',
                    prefixIcon: Icons.person),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Debes introducir los apellidos.';
                  } else if (value!.length < 6) {
                    return 'Los apellidos deben tener al menos 6 caracteres.';
                  }
                },
              ),

              SizedBox(
                height: 10,
              ),

              // Campo FECHA DE NACIMIENTO.
              TextFormField(
                controller: datecontroller,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'dd/mm/yyyy',
                    labelText: 'Fecha de nacimiento',
                    prefixIcon: Icons.date_range),
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      helpText: 'Fecha de nacimiento',
                      // locale: Locale..., TODO: Implementar lenguaje ESPAÑOL.
                      cancelText: 'Cancelar',
                      confirmText: 'Aceptar');

                  if (selectedDate != null) {
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(selectedDate);

                    datecontroller.text = formattedDate;

                    setState(() {});
                  }
                },
              ),

              SizedBox(
                height: 10,
              ),

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
                height: 10,
              ),

              // Campo NOMBRE DE USUARIO.
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre de usuario',
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icons.person),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Debe introducir un nombre de usuario.';
                  }
                },
              ),

              SizedBox(
                height: 10,
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
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // Oculto el teclado.
                  FocusScope.of(context).unfocus();

                  // Si el formulario es válido...
                  if (registerForm.isValidForm()) {
                    // TODO: Enviar POST al servidor para crear el usuario.

                    Navigator.pushReplacementNamed(context, 'base');
                  }
                },
              )
            ],
          )),
    );
  }
}
