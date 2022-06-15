import 'package:aygp_frontend/models/diary_entry.dart';
import 'package:flutter/material.dart';

class DiaryFormProvider extends ChangeNotifier {
  // Propiedades.
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  DiaryEntry diaryEntry;

  DiaryFormProvider(this.diaryEntry);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
