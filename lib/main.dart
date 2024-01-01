import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/root_page.dart';
import 'package:soundstream_flutter/providers/audio_queue_provider/audio_queue_provider.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/providers/playlists_provider.dart';
import 'package:soundstream_flutter/providers/theme_provider.dart';
import 'package:soundstream_flutter/providers/upload_provider.dart';
import 'package:soundstream_flutter/services/auth_service.dart';
import 'package:soundstream_flutter/services/playlist_service.dart';

void main() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.soundstream.channel.audio',
      androidNotificationChannelName: 'Audio playback',
    );
  }

  runApp(const MyApp());
}

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
        ChangeNotifierProvider(create: (_) => UploadProvider()),
      ],
      child: const RootPage(),
    );
  }
}
