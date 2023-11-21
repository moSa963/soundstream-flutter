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
              child: Hero(
                  tag: "user ${user.username}",
                  child: Image.network(User.getImgUri(user.username).toString(),
                      fit: BoxFit.cover, alignment: Alignment.topCenter)),
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NavigatorBackButton(),
                const Spacer(),
                Text(user.name,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    textScaler: const TextScaler.linear(2),
                    overflow: TextOverflow.ellipsis),
                  Text("@${user.username}"),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
