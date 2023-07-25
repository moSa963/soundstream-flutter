import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/home_page/home_nav_page.dart';
import 'package:soundstream_flutter/pages/register_page/register_page.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/providers/theme_provider.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundstream',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: context.watch<ThemeProvider>().themeMode,
      home: Consumer<AuthProvider>(
        builder: (context, value, child) {
          if (value.loading || value.auth == null || child == null) {
            return const RegisterPage();
          }

          return child;
        },
        child: HomeNavPage(),
      ),
    );
  }
}
