import 'package:flutter/material.dart';

class LoadingBox extends StatelessWidget {
  const LoadingBox({super.key});

@override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: const CircularProgressIndicator(),
      );
  }
}