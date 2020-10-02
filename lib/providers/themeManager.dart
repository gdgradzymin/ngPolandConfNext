import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/sharedPreferences/darkTheme.dart';

class ThemeNotifier with ChangeNotifier {
  DarkThemePreferences darkThemePreferences = DarkThemePreferences();

  bool _darkTheme = false;

  get darkTheme {
    return _darkTheme;
  }

  set darkTheme(bool value) {
    _darkTheme = value;

    darkThemePreferences.setDarkTheme(value);

    notifyListeners();
  }
}
