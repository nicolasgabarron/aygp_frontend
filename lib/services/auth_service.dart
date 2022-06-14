import 'dart:convert';
import 'dart:io';

import 'package:aygp_frontend/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  // Propiedades.
  final String _baseUrl = 'localhost:9090';

  // SecureStorage donde almacenaremos el JWT.
  final secureStorage = new FlutterSecureStorage();

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
      NotificationsService.showSnackbar(
          'No se ha podido crear la cuenta. Error: $response.body', true);

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

        // Substring para quitar la cabecera "nicogbdev_jwt="
        String shortJwt = splittedCookies[0].substring(14);

        // Guardo el JWT en el SecureStorage.
        await secureStorage.write(key: 'nicogbdev_jwt', value: shortJwt);

        // Muestro SnackBar satisfacotorio.
        NotificationsService.showSnackbar('¡Login satisfactorio!', false);

        return shortJwt;
      }
    } else {
      NotificationsService.showSnackbar('Revise las credenciales.', true);

      return 'error'; // TODO: Cambiar por mensaje con más información (quizás el propio status code.)
    }
  }

  Future<bool?> logoutUser() async {
    // Endpoint final.
    final url = Uri.http(_baseUrl, '/api/auth/logout');

    // Ejecuto la petición.
    final response = await http.post(url);

    if (response.statusCode == 200) {
      // Limpio el JWT almacenado en el SecureStorage.
      secureStorage.delete(key: 'nicogbdev_jwt');

      // Devuelvo true en señal de que la petición se ha ejecutado correctamente.
      return true;
    } else {
      return false;
    }
  }

  Future<String> readToken() async {
    // Compruebo si existe la propiedad del JWT en el SecureStorage.
    // En caso negativo, devuelvo un String vacío ya que no puedo trabajar
    // a posteriori con nulos.
    return await secureStorage.read(key: 'nicogbdev_jwt') ?? '';
  }
}
