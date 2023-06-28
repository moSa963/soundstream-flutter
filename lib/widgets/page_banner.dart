import 'package:flutter/material.dart';

class PageBanner extends StatelessWidget {
  final Widget? image;
  final List<Widget>? actions;
  final String title;
  final String subtitle;

  const PageBanner({
    super.key,
    this.actions,
    this.image,
    this.subtitle = "",
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient:
            RadialGradient(radius: 0.9, focal: Alignment.topCenter, colors: [
          Theme.of(context).primaryTextTheme.bodyLarge?.color?.withAlpha(120) ??
              Colors.white,
          Colors.transparent,
        ]),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kToolbarHeight),
          Center(
            child: Container(
              decoration:
                  const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 25)]),
              constraints: const BoxConstraints(maxWidth: 150),
              child: AspectRatio(aspectRatio: 1, child: image),
            ),
          ),
          const SizedBox(height: 10),
          Text(title,
              textScaleFactor: 2,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(subtitle),
          const SizedBox(height: 15),
          Row(children: actions ?? []),
        ],
      ),
    );
  }
}
