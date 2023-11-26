import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/providers/theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
      onChanged: (v) {
        context
            .read<ThemeProvider>()
            .setThemeMode(v ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}