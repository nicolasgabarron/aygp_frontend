import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Color base de la pantalla.
      color: Colors.grey[200],
      // Dimensiones que ocupará el widget en la pantalla.
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Contenedor de la parte superior.
          _PurpleBox(),

          // Icono de la persona.
          _HeaderIcon(),

          // Tarjeta de Login.
          this.child,
        ],
      ),
    );
  }
}

// Widget extraído para mayor modularidad. Consiste en crear el fondo superior de la pantalla.
class _PurpleBox extends StatelessWidget {
  const _PurpleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      // Ocupa todo el ancho.
      width: double.infinity,
      // Ocupa el 40% del alto de la pantalla.
      height: size.height * 0.4,
      // Establezco el fondo en un degradado.
      decoration: _purpleBackground(),
      // El stack contendrá las burbujas.
      child: Stack(
        children: const [
          Positioned(child: _Bubble(), top: 90, left: 30,),
          Positioned(child: _Bubble(), top: -40, left: -30,),
          Positioned(child: _Bubble(), top: -50, right: -20,),
          Positioned(child: _Bubble(), bottom: -50, left: 10,),
          Positioned(child: _Bubble(), top: 120, right: 20,),
        ],
      ),
    );
  }

  // Método que devuelve el widget BoxDecoration con la configuración establecida.
  BoxDecoration _purpleBackground() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]
    )
  );
}

// Widget extaído que compone cada una de las burbujas del fondo superior.
class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Tamaño de cada burbuja.
      width: 100,
      height: 100,
      // Utilizo el decoration para poder poner atributos tales como BorderRadius (necesario para hacerlo redondo).
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.1)
      ),
    );
  }
}

// Widget extraído que consiste en el icono superior de login (la personita).
class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Utilizo SafeArea para no crear conflictos con dispositivos con Notch.
    return SafeArea(
      child: Container(
        // Ocupa el ancho disponible.
        width: double.infinity,
        // Margen superior de 35 px.
        margin: EdgeInsets.only( top: 35 ),
        // Icono de la persona, en color blanco y con tamaño 100.
        child: Icon(Icons.person_pin, color: Colors.white, size: 100,),
      ),
    );
  }
}

