import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soundstream_flutter/providers/theme_provider.dart';

void main() {
  late ThemeProvider sut;

  setUp(() {
    sut = ThemeProvider();
  });

  test("inital values are correct", () {
    expect(sut.mode, ThemeMode.light);
    expect(sut.themeData, ThemeData.light(useMaterial3: true));
  });

  test("setThemeMode method sets 'mode' and 'themeData' values", () {
    sut.setThemeMode(ThemeMode.dark);
    expect(sut.mode, ThemeMode.dark);
    expect(sut.themeData, ThemeData.dark(useMaterial3: true));
  });
}
