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
  // final String _baseUrl = '192.168.0.130:9090'; // ANDROID

  final secureStorage = new FlutterSecureStorage();
  final List<SucesoClave> sucesosClave = [];
  bool isLoading = true;
  bool isSaving = false;
  late SucesoClave selectedSuceso;

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
}
