import 'dart:convert';
import 'dart:io';

import 'package:aygp_frontend/models/recordatorio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'notifications_service.dart';

class RecordatorioService extends ChangeNotifier {
  // Propiedades.
  final String _baseUrl = 'localhost:9090';
  // final String _baseUrl = '192.168.0.130:9090'; // ANDROID

  final secureStorage = new FlutterSecureStorage();
  final List<Recordatorio> recordatorios = [];
  bool isLoading = true;
  bool isSaving = false;
  late Recordatorio selectedRecordatorio;

  Future<List<Recordatorio>> loadRecordatorios() async {
    // NOTIFICO QUE EMPIEZA EL PROCESO DE CARGA.
    this.isLoading = true;
    notifyListeners();

    // Endpoint final
    final url = Uri.http(_baseUrl, '/api/recordatorios/todos');

    // Obtengo el JWT.
    final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

    // Headers (mando el JWT).
    final headers = {HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt'};

    // Almaceno la petición.
    final response = await http.get(url, headers: headers);

    // Se comprueban el Status code.
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

      // Recorro cada MAPA (un Json) para transformarlo en objeto y añadirlo a la lista.
      rawMapResponse.forEach(
        (element) {
          final tempRecordatorio = Recordatorio.fromMap(element);
          this.recordatorios.add(tempRecordatorio);
        },
      );

      // NOTIFICO QUE SE HA DEJADO DE CARGAR.
      this.isLoading = false;
      notifyListeners();

      return this.recordatorios;
    } else {
      NotificationsService.showSnackbar(
          'No se ha podido traer los datos del servidor.', true);

      return this.recordatorios;
    }
  }

  Future saveOrCreate(Recordatorio recordatorio) async {
    isSaving = true;
    notifyListeners();

    // CREACIÓN DE RECORDATORIO.
    if (recordatorio.id == null) {
      // Endpoint final
      final url = Uri.http(_baseUrl, '/api/recordatorios/nuevo');

      // Obtengo el JWT.
      final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

      // Headers (mando el JWT y el Content/Type).
      final headers = {
        HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt',
        HttpHeaders.contentTypeHeader: 'application/json'
      };

      // Realizo la petición.
      final response =
          await http.post(url, headers: headers, body: recordatorio.toJson());

      // Si la petición se ha ejecutado correctamente...
      if (response.statusCode == 200) {
        // Notifico de que se ha realizado correctamente.
        NotificationsService.showSnackbar(
            'Recordatorio creado satisfactoriamente.', false);

        // Añado a la lista de entradas locales la devuelta por el servidor.
        recordatorios.add(Recordatorio.fromMap(json.decode(response.body)));
        notifyListeners();
      } else {
        // Notifico de que NO se ha realizado correctamente.
        NotificationsService.showSnackbar(
            'Ha ocurrido algún error creando el recordatorio.', true);
      }
    }
    // MODIFICACIÓN DE ENTRADA DE DIARIO.
    else {
      // Endpoint final
      final url =
          Uri.http(_baseUrl, '/api/recordatorios/modificar/${recordatorio.id}');

      // Obtengo el JWT.
      final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

      // Headers (mando el JWT y el Content/Type).
      final headers = {
        HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt',
        HttpHeaders.contentTypeHeader: 'application/json'
      };

      // Realizo la petición.
      final response =
          await http.patch(url, headers: headers, body: recordatorio.toJson());

      if (response.statusCode == 200) {
        // Notifico de que se ha realizado correctamente.
        NotificationsService.showSnackbar(
            'Recordatorio actualizado satisfactoriamente.', false);

        // Actualizo la lista de la vista principal.
        final findDiaryEntryIndex = this
            .recordatorios
            .indexWhere((element) => element.id == recordatorio.id);
        this.recordatorios[findDiaryEntryIndex] = recordatorio;

        isSaving = false;
        notifyListeners();
      } else {
        // Notifico de que NO se ha realizado correctamente.
        NotificationsService.showSnackbar(
            'Ha ocurrido algún error actualizando el recordatorio.', true);
      }
    }
  }

  Future makeItDone(Recordatorio recordatorio) async {
    // Endpoint final
    final url =
        Uri.http(_baseUrl, '/api/recordatorios/realizado/${recordatorio.id}');

    // Obtengo el JWT.
    final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

    // Headers (mando el JWT y el Content/Type).
    final headers = {HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt'};

    // Ejecuto la petición.
    final response = await http.patch(url, headers: headers);

    // Compruebo que se ha eliminado satisfactoriamente (200 No-Content)
    if (response.statusCode == 200) {
      // Notifico de que se ha realizado correctamente.
      NotificationsService.showSnackbar(
          'Recordatorio eliminado satisfactoriamente.', false);

      // La elimino de la lista global local.
      this.recordatorios.remove(recordatorio);
      notifyListeners();
    } else {
      // Notifico de que NO se ha realizado correctamente.
      NotificationsService.showSnackbar(
          'Ha ocurrido algún error eliminando el recordatorio.', true);
    }
  }

  Future delete(Recordatorio recordatorio) async {
    // Endpoint final
    final url =
        Uri.http(_baseUrl, '/api/recordatorios/eliminar/${recordatorio.id}');

    // Obtengo el JWT.
    final userJwt = await secureStorage.read(key: 'nicogbdev_jwt');

    // Headers (mando el JWT y el Content/Type).
    final headers = {HttpHeaders.cookieHeader: 'nicogbdev_jwt=$userJwt'};

    // Ejecuto la petición.
    final response = await http.delete(url, headers: headers);

    // Compruebo que se ha eliminado satisfactoriamente (200 No-Content)
    if (response.statusCode == 200) {
      // Notifico de que se ha realizado correctamente.
      NotificationsService.showSnackbar(
          'Recordatorio eliminado satisfactoriamente.', false);

      // La elimino de la lista global local.
      this.recordatorios.remove(recordatorio);
      notifyListeners();
    } else {
      // Notifico de que NO se ha realizado correctamente.
      NotificationsService.showSnackbar(
          'Ha ocurrido algún error eliminando el recordatorio.', true);
    }
  }
}
