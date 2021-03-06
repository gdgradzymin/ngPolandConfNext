import 'package:flutter/material.dart';
import 'package:ngPolandConf/sharedPreferences/darkTheme.dart';

class ThemeNotifier with ChangeNotifier {
  DarkThemePreferences darkThemePreferences = DarkThemePreferences();

  bool _darkTheme = false;

  bool get darkTheme {
    return _darkTheme;
  }

  set darkTheme(bool value) {
    _darkTheme = value;

    darkThemePreferences.setDarkTheme(value);

    notifyListeners();
  }
}
