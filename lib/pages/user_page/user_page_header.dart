import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/widgets/button/navigator_back_button.dart';
import 'package:soundstream_flutter/widgets/fade_shader_mask.dart';

class UserPageHeader extends StatelessWidget {
  const UserPageHeader({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Positioned.fill(
            child: FadeShaderMask(
              begin: Alignment.center,
              child: Hero(
                  tag: "user ${user.username}",
                  child: Image.network(user.imgUri.toString(),
                      fit: BoxFit.cover, alignment: Alignment.topCenter)),
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NavigatorBackButton(),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.background.withAlpha(200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                          textScaler: const TextScaler.linear(2),
                          overflow: TextOverflow.ellipsis),
                      Text("@${user.username}"),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
