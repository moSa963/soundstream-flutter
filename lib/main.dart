import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/home_page/home_page.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/providers/theme_provider.dart';
import 'package:soundstream_flutter/services/playlist_service.dart';

void main() => runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: ChangeNotifierProvider<PlaylistsProvider>(
        create: (_) => PlaylistsProvider(service: PlaylistService()),
        child: const MyApp(),
      ),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundstream',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: HomePage(),
      themeMode: context.watch<ThemeProvider>().themeMode,
    );
  }
}
