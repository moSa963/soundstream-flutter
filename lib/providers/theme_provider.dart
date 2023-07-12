import 'package:flutter/material.dart';
import 'package:soundstream_flutter/providers/provider.dart';

class ThemeProvider extends Provider {
  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() : _themeMode = ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
  }
}
