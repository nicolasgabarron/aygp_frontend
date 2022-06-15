import 'package:aygp_frontend/models/diary_entry.dart';
import 'package:flutter/material.dart';

class DiaryService extends ChangeNotifier {
  // Propiedades.
  final String _baseUrl = 'localhost:9090';
  final List<DiaryEntry> diaryEntries = [];

  // TODO: Hacer FETCH de DiaryEntries.
}
