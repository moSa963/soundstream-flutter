import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:soundstream_flutter/providers/provider.dart';

class ThemeProvider extends Provider {
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  bool _useDeviceTheme = true;
  bool get useDeviceTheme => _useDeviceTheme;

  set useDeviceTheme(bool val) {
    _useDeviceTheme = val;
    final platformDark =
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;

    if (!val) return;

    setThemeMode(platformDark ? ThemeMode.dark : ThemeMode.light);
  }

  ThemeProvider() {
    _themeMode = ThemeMode.dark;
    useDeviceTheme = true;
  }

  void setThemeMode(ThemeMode mode) {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
  }
}
