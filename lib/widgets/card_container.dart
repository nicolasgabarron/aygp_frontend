import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

  // Recibo propiedad child para poder reutilizar este widget tantas veces como queramos según el contexto.
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap del Container para poder separarlo de los bordes.
    return Padding(
      // Padding exterior respecto los bordes de la pantalla.
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        // Estilo de la propia tarjeta.
        decoration: _createCardShape(),
        // Muestro el child pasado por parámetro a la hora de construir el widget.
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(color: Colors.black54, blurRadius: 15)
    ]
  );
}
