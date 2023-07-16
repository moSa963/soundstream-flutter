import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/root_page.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/providers/theme_provider.dart';
import 'package:soundstream_flutter/services/auth_service.dart';
import 'package:soundstream_flutter/services/playlist_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (_) => AuthProvider(service: const AuthService())),
        ChangeNotifierProvider(
            create: (_) => PlaylistsProvider(service: const PlaylistService())),
        ChangeNotifierProvider(create: (_) => AudioQueueProvider()),
      ],
      child: const RootPage(),
    );
  }
}
