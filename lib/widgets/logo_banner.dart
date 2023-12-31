import 'package:flutter/material.dart';

class LogoBanner extends StatelessWidget {
  const LogoBanner(
      {super.key,
      this.direction = Axis.vertical,
      this.maxHeight = 150.0,
      this.title});
  final Axis direction;
  final double maxHeight;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        direction: direction,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Container(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: const AspectRatio(
                  aspectRatio: 1,
                  child: FlutterLogo(
                    size: double.infinity,
                  )),
            ),
          ),
          if (title != null)
            Text(
              title ?? "",
              textScaler: const TextScaler.linear(2),
            ),
        ],
    );
  }
}
