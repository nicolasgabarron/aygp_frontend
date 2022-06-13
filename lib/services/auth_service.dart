import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  // Propiedades.
  final String _baseUrl = 'localhost:9090/api/auth';

  Future<String?> createUser(String name, String surname, DateTime date,
      String email, String username, String password) async {
    // JSON de SALIDA con los datos introducidos por el usuario.
    final Map<String, dynamic> registerData = {
      'email': email,
      'username': username,
      'password': password,
      'nombre': name,
      'apellidos': surname,
      'fechaNacimiento': date
    };

    // Endpoint final.
    final url = Uri.http(_baseUrl, '/signup');

    // Ejecuto la petición.
    final response = await http.post(url, body: json.encode(registerData));

    final Map<String, dynamic> recievedData = json.decode(response.body);

    // IMPRIMO TEMPORALMENTE LOS DATOS.
    return recievedData.toString();
  }

  Future<String?> loginUser(String username, String password) async {
    // JSON de SALIDA con los datos introducidos por el usuario.
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password
    };

    // Endpoint final.
    final url = Uri.http(_baseUrl, '/signin');

    // Ejecuto la petición.
    final response = await http.post(url, body: json.encode(loginData));

    final Map<String, dynamic> recievedData = json.decode(response.body);

    final String jwt = response.headers[
        'Set-Cookie']!; // Si hace login, este header va a venir si o si.

    return jwt;
  }
}
