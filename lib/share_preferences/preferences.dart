import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // Propiedad global la cual se inicializará en el Main.
  static late SharedPreferences _prefs;

  // Propiedades globales que serán definidas a la hora de hacer Login.
  static String _username = '';
  static String _name = '';
  static String _surname = '';
  static String _quote = '';
  static String _author = '';
  static String _quickNote = '';
  static bool _isDarkMode = false;

  // Método asíncrono que inicializa la instancia global (singleton) de getInstance()
  // en el main.dart
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getters y setters.
  static String get username {
    return _prefs.getString('username') ?? _name;
  }

  static set username(String username) {
    _username = username;

    _prefs.setString('username', username);
  }

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name(String name) {
    _name = name;

    _prefs.setString('name', name);
  }

  static String get surname {
    return _prefs.getString('surname') ?? _surname;
  }

  static set surname(String surname) {
    _surname = surname;

    _prefs.setString('surname', surname);
  }

  static String get quote {
    return _prefs.getString('quote') ?? _quote;
  }

  static set quote(String quote) {
    _quote = quote;

    _prefs.setString('quote', quote);
  }

  static String get author {
    return _prefs.getString('author') ?? _author;
  }

  static set author(String author) {
    _author = author;

    _prefs.setString('author', author);
  }

  static String get quickNote {
    return _prefs.getString('quickNote') ?? _quickNote;
  }

  static set quickNote(String quickNote) {
    _quickNote = quickNote;

    _prefs.setString('quickNote', quickNote);
  }

  static bool get isDarkMode {
    return _prefs.getBool('darkmode') ?? _isDarkMode;
  }

  static set isDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;

    _prefs.setBool('darkmode', isDarkMode);
  }
}
