import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/overflow_animated_text.dart';

class PageBanner extends StatelessWidget {
  final Widget? image;
  final List<Widget>? actions;
  final List<Widget>? leading;
  final String title;
  final String subtitle;

  const PageBanner({
    super.key,
    this.actions,
    this.leading,
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
          Theme.of(context).colorScheme.primary.withAlpha(120),
          Colors.transparent,
        ]),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kToolbarHeight / 2),
          if (leading != null) Row(children: leading ?? []),
          const SizedBox(height: kToolbarHeight / 2),
          Center(
            child: Container(
              decoration:
                  const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 25)]),
              constraints: const BoxConstraints(maxWidth: 150),
              child: AspectRatio(aspectRatio: 1, child: image),
            ),
          ),
          const SizedBox(height: 10),
          OverflowAnimatedText(title,
              textScaleFactor: 2,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          if (subtitle.isNotEmpty)
            Text(subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 15),
          Row(children: actions ?? []),
        ],
      ),
    );
  }
}
