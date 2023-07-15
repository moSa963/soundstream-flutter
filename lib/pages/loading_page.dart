import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/logo_banner.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LogoBanner(title: "SoundStream", direction: Axis.vertical),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}