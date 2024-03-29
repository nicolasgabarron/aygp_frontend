import 'dart:convert';
import 'dart:io';

import 'package:aygp_frontend/services/notifications_service.dart';
import 'package:aygp_frontend/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  // Propiedades.
  final String _baseUrl = 'localhost:9090';
  // final String _baseUrl = '192.168.0.100:9090'; // ANDROID

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

      // Muestro mensaje de registro satisfactorio.
      NotificationsService.showSnackbar('¡Bienvenido!', false);

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
      final Map<String, dynamic> recievedData =
          json.decode(utf8.decode(response.bodyBytes));

      final String? jwt = response.headers[
          'set-cookie']; // Si hace login, este header va a venir si o si.

      // Obtengo datos personales.
      Preferences.username = recievedData['username'];
      Preferences.name = recievedData['nombre'];
      Preferences.surname = recievedData['apellidos'];

      // Obtengo frase célebre del día.
      //final endpointFrase =
      //    Uri.https('frasedeldia.azurewebsites.net', '/api/phrase');

      // final quoteResponse = await http.get(endpointFrase);

      //if (quoteResponse.statusCode == 200) {
      //final Map<String, dynamic> recievedQuote =
      //    json.decode(utf8.decode(quoteResponse.bodyBytes));

      Preferences.quote = 'Lleva tiempo llegar a ser joven';
      Preferences.author = 'Pablo Picasso';
      // }

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

      // TODO: ELIMINAR SHARED PREFERENCES.

      // Muestro mensaje de Logout satisfactorio.
      NotificationsService.showSnackbar(
          'Has salido correctamente. ¡Hasta pronto!', false);

      // Devuelvo true en señal de que la petición se ha ejecutado correctamente.
      return true;
    } else {
      // Muestro mensaje de Logout satisfactorio.
      NotificationsService.showSnackbar(
          'No se ha podido cerrar la sesión. Inténtelo de nuevo', true);

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
