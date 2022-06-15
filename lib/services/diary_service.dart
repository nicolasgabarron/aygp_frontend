import 'dart:convert';
import 'dart:io';

import 'package:aygp_frontend/models/diary_entry.dart';
import 'package:aygp_frontend/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DiaryService extends ChangeNotifier {
  // Propiedades.
  final String _baseUrl = 'localhost:9090';
  final secureStorage = new FlutterSecureStorage();
  final List<DiaryEntry> diaryEntries = [];
  bool isLoading = true;

  DiaryService() {
    loadDiaryEntries();
  }

  Future<List<DiaryEntry>> loadDiaryEntries() async {
    // NOTIFICO QUE EMPIEZA EL PROCESO DE CARGA.
    this.isLoading = true;
    notifyListeners();

    // Endpoint final
    final url = Uri.http(_baseUrl, '/api/diario/entradas');

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

      // Recorro cada MAPA (un Json) para transformarlo en objeto y añadirlo a la lista.
      rawMapResponse.forEach(
        (element) {
          final tempDiaryEntry = DiaryEntry.fromMap(element);
          this.diaryEntries.add(tempDiaryEntry);
        },
      );

      // NOTIFICO QUE SE HA DEJADO DE CARGAR.
      this.isLoading = false;
      notifyListeners();

      return this.diaryEntries;
    } else {
      NotificationsService.showSnackbar(
          'No se ha podido traer los datos del servidor.', true);

      return this.diaryEntries;
    }
  }
}
