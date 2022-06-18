import 'package:aygp_frontend/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height -
          kToolbarHeight -
          kBottomNavigationBarHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[200]!, Colors.blue[600]!])),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '¡Bienvenido,',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              '${Preferences.name} ${Preferences.surname}!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Frase del día:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            _QuoteWidget(),
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Anotaciones rápidas',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Card(
              color: Colors.white.withOpacity(0.75),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) => Preferences.quickNote = value,
                  initialValue: Preferences.quickNote,
                  maxLines: 15,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Introduce aquí alguna anotación rápida...'),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class _QuoteWidget extends StatelessWidget {
  const _QuoteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '📖',
          style: TextStyle(fontSize: 50),
        ),
        SizedBox(
          width: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${Preferences.quote != '' ? "\"${Preferences.quote}\"" : "No se ha podido obtener..."}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              'Autor: ${Preferences.author != '' ? Preferences.author : "No se ha podido obtener..."}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.5,
                  fontStyle: FontStyle.italic),
            )
          ],
        )
      ],
    );
  }
}
