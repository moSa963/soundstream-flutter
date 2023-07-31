

import 'package:flutter/material.dart';

class NavigatorBackButton extends StatelessWidget {
  const NavigatorBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Navigator.canPop(context) ? BackButton(onPressed: () {
        Navigator.pop(context);
      },) : null,
    );
  }
}