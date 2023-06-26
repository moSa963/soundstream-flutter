import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;
  ThemeData get themeData => _themeData;

  ThemeMode _mode;
  ThemeMode get mode => _mode;

  ThemeProvider() : _mode = ThemeMode.light {
    _themeData = _getThemeData(_mode);
  }

  void setThemeMode(ThemeMode mode) {
    if (mode == _mode) return;

    _mode = mode;
    _themeData = _getThemeData(_mode);
    notifyListeners();
  }

  ThemeData _getThemeData(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return ThemeData.dark(useMaterial3: true);
      default:
        return ThemeData.light(useMaterial3: true);
    }
  }
}
