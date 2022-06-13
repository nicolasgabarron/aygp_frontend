import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  // Propiedades.
  final String _baseUrl = 'localhost:9090';

  Future<String?> createUser(String name, String surname, String date,
      String email, String username, String password) async {
    // JSON de SALIDA con los datos introducidos por el usuario.
    final Map<String, dynamic> registerData = {
      "username": username,
      "email": email,
      "password": password,
      "nombre": name,
      "apellidos": surname,
      "fechaNacimiento": date,
      "ciudadNacimiento": "No definida",
      "roles": ["usuario"]
    };

    print('$username - $email - $password - $name - $surname - $date - $date');

    // Endpoint final.
    final url = Uri.http(_baseUrl, '/api/auth/signup');

    // Headers.
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    // Ejecuto la petición.
    final response =
        await http.post(url, headers: headers, body: json.encode(registerData));

    // Compruebo el STATUS CODE para saber si ha ido correctamente la petición.
    if (response.statusCode == 201) {
      final Map<String, dynamic> recievedData = json.decode(response.body);

      // IMPRIMO TEMPORALMENTE LOS DATOS.
      return recievedData.toString();
    } else {
      return 'error'; // TODO: Cambiar por mensaje con más información (quizás el propio status code.)
    }
  }

  Future<String?> loginUser(String username, String password) async {
    // JSON de SALIDA con los datos introducidos por el usuario.
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password
    };

    // Endpoint final.
    final url = Uri.http(_baseUrl, '/api/auth/signin');

    // Headers.
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    // Ejecuto la petición.
    final response =
        await http.post(url, headers: headers, body: json.encode(loginData));

    // Compruebo el STATUS CODE para saber si ha ido correctamente la petición.
    if (response.statusCode == 200) {
      final Map<String, dynamic> recievedData = json.decode(response.body);

      final String? jwt = response.headers[
          'set-cookie']; // Si hace login, este header va a venir si o si.

      if (jwt != null) {
        var splittedCookies = jwt.split(';');

        // TODO: Hacer substring para quitar el "nicogbdev_jwt".
        return splittedCookies[0];
      }
    } else {
      return 'error'; // TODO: Cambiar por mensaje con más información (quizás el propio status code.)
    }
  }
}