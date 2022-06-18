import 'dart:convert';
import 'dart:io';

import 'package:aygp_frontend/models/suceso_clave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'notifications_service.dart';

class SucesoClaveService extends ChangeNotifier {
  // Propiedades.
  final String _baseUrl = 'localhost:9090';
  // final String _baseUrl = '192.168.0.100:9090'; // ANDROID

  final secureStorage = new FlutterSecureStorage();
  final List<SucesoClave> sucesosClave = [];
  bool isLoading = true;
  bool isSaving = false;
  late SucesoClave selectedSuceso;

  SucesoClaveService() {
    this.loadSucesosClave();
  }

  Future<List<SucesoClave>> loadSucesosClave() async {
    // NOTIFICO QUE EMPIEZA EL PROCESO DE CARGA
    this.isLoading = true;
    notifyListeners();

    // Endpoint final
    final url = Uri.http(_baseUrl, '/api/sclave/sucesos');

    // Obtengo el JWT.
    final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

    // Headers (mando el JWT).
    final headers = {HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt'};

    // Almaceno la petición.
    final response = await http.get(url, headers: headers);

    // Compruebo posibles errores en la respuesta.
    if (response.statusCode == 200) {
      // Recupero la lista de JSONs.
      final List<dynamic> rawResponse = json.decode(response.body);

      // Creo una lista de MAPAS (Esto es necesario ya que el parser de
      // DiaryEntry (modelo) fromMap, necesita un Mapa, y Flutter no hace la conversión
      // directa con el json.decode)
      final List<Map<String, dynamic>> rawMapResponse = [];

      // Recorro cada elemento de la respuesta en BRUTO.
      rawResponse.forEach((element) {
        rawMapResponse.add(element);
      });

      // Recorro cada MAPA (json) para transformarlo en objeto y añadirlo a la lista.
      rawMapResponse.forEach((element) {
        final tempSucesoClave = SucesoClave.fromMap(element);

        this.sucesosClave.add(tempSucesoClave);
      });

      // Notifico que se ha dejado de cargar.
      this.isLoading = false;
      notifyListeners();

      return this.sucesosClave;
    } else {
      NotificationsService.showSnackbar(
          'No se ha podido traer los datos del servidor.', true);

      return this.sucesosClave;
    }
  }

  Future saveOrCreate(SucesoClave sucesoClave) async {
    // Indico que procedo a guardar (o modificar) un Suceso clave.
    isSaving = true;
    notifyListeners();

    // CREACIÓN DE SUCESO CLAVE.
    if (sucesoClave.id == null) {
      // Endpoint final
      final url = Uri.http(_baseUrl, '/api/sclave/sucesos');

      // Obtengo el JWT.
      final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

      // Headers (mando el JWT y el Content/Type).
      final headers = {
        HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt',
        HttpHeaders.contentTypeHeader: 'application/json'
      };

      // Realizo la petición.
      final response =
          await http.post(url, headers: headers, body: sucesoClave.toJson());

      // Si la petición se ha ejecutado correctamente...
      if (response.statusCode == 201) {
        // Notifico de que se ha realizado correctamente.
        NotificationsService.showSnackbar(
            'Suceso Clave creado satisfactoriamente.', false);

        // Añado a la lista de entradas locales la devuelta por el servidor.
        sucesosClave.add(SucesoClave.fromMap(json.decode(response.body)));
        notifyListeners();
      } else {
        // Notifico de que NO se ha realizado correctamente.
        NotificationsService.showSnackbar(
            'Ha ocurrido algún error creando el suceso clave.', true);
      }
    }
    // MODIFICACIÓN DE SUCESO CLAVE
    else {
      // Endpoint final
      final url = Uri.http(_baseUrl, '/api/sclave/sucesos/${sucesoClave.id}');

      // Obtengo el JWT.
      final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

      // Headers (mando el JWT y el Content/Type).
      final headers = {
        HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt',
        HttpHeaders.contentTypeHeader: 'application/json'
      };

      // Realizo la petición.
      final response =
          await http.patch(url, headers: headers, body: sucesoClave.toJson());

      if (response.statusCode == 200) {
        // Notifico de que se ha realizado correctamente.
        NotificationsService.showSnackbar(
            'Suceso Clave modificado satisfactoriamente.', false);

        // Actualizo la lista de la vista principal.
        final findDiaryEntryIndex = this
            .sucesosClave
            .indexWhere((element) => element.id == sucesoClave.id);
        this.sucesosClave[findDiaryEntryIndex] = sucesoClave;

        isSaving = false;
        notifyListeners();
      } else {
        // Notifico de que NO se ha realizado correctamente.
        NotificationsService.showSnackbar(
            'Ha ocurrido algún error actualizando el suceso clave.', true);
      }
    }
  }

  Future delete(SucesoClave sucesoClave) async {
    // Endpoint final
    final url = Uri.http(_baseUrl, '/api/sclave/sucesos/${sucesoClave.id}');

    // Obtengo el JWT.
    final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

    // Headers (mando el JWT y el Content/Type).
    final headers = {HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt'};

    // Ejecuto la petición.
    final response = await http.delete(url, headers: headers);

    // Compruebo que se ha eliminado satisfactoriamente (204 No-Content)
    if (response.statusCode == 204) {
      // Notifico de que se ha realizado correctamente.
      NotificationsService.showSnackbar(
          'Suceso clave eliminado satisfactoriamente.', false);

      // La elimino de la lista global local.
      this.sucesosClave.remove(sucesoClave);
      notifyListeners();
    } else {
      // Notifico de que NO se ha realizado correctamente.
      NotificationsService.showSnackbar(
          'Ha ocurrido algún error eliminando el suceso clave.', true);
    }
  }
}
