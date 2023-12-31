import 'package:flutter/material.dart';
import 'package:soundstream_flutter/widgets/button/navigator_back_button.dart';
import 'package:soundstream_flutter/widgets/movable_box.dart';
import 'package:soundstream_flutter/widgets/overflow_animated_text.dart';

class PageBanner extends StatelessWidget {
  final Widget? image;
  final List<Widget>? actions;
  final List<Widget>? leading;
  final String title;
  final String subtitle;
  final Color? color;

  const PageBanner({
    super.key,
    this.actions,
    this.leading,
    this.image,
    this.subtitle = "",
    this.title = "",
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient:
            RadialGradient(radius: 0.7, focal: Alignment.topCenter, colors: [
          color?.withAlpha(150) ??
              Theme.of(context).colorScheme.primary.withAlpha(150),
          color?.withAlpha(0) ??
              Theme.of(context).colorScheme.primary.withAlpha(0),
        ]),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NavigatorBackButton(),
          if (leading != null) Row(children: leading ?? []),
          const SizedBox(height: kToolbarHeight / 2),
          Center(
              child: MovableBox(
            child: Container(
              decoration:
                  const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 25)]),
              constraints: const BoxConstraints(maxWidth: 150),
              child: AspectRatio(aspectRatio: 1, child: image),
            ),
          )),
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
