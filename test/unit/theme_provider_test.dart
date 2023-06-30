import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soundstream_flutter/providers/theme_provider.dart';

void main() {
  late ThemeProvider sut;

  setUp(() {
    sut = ThemeProvider();
  });

  test("inital values are correct", () {
    expect(sut.themeMode, ThemeMode.system);
  });

  test("setThemeMode method sets 'themeMode' value", () {
    sut.setThemeMode(ThemeMode.dark);
    expect(sut.themeMode, ThemeMode.dark);
  });
}
