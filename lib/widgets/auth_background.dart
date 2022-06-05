import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key? key}) : super(key: key);

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
      width: double.infinity,
      height: size.height * 0.4,
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

  BoxDecoration _purpleBackground() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]
    )
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.1)
      ),
    );
  }
}

