import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/home_page.dart';
import 'package:soundstream_flutter/providers/theme_provider.dart';

void main() => runApp(
  ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider(),
    child: const MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundstream',
      theme: context.watch<ThemeProvider>().themeData,
      home: const HomePage(),
    );
  }
}
