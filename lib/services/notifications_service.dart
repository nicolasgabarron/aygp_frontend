import 'package:flutter/material.dart';

class NotificationsService {
  static late GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, bool error) {
    final snackBar = SnackBar(
        backgroundColor: error ? Colors.red[300] : Colors.green[200],
        content: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ));

    // Muestro el widget creado arriba.
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
