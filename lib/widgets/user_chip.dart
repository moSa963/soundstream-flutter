

import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/pages/user_page/show_user_page.dart';
import 'package:soundstream_flutter/widgets/button/scale_gesture_detector.dart';
import 'package:soundstream_flutter/widgets/user_avatar.dart';

class UserChip extends StatelessWidget {
  const UserChip({super.key, this.user, this.onTap});
  final User? user;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
          onTap: () => onTap == null ? _defaultAction(context) : onTap?.call(), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserAvatar(user: user, maxWidth: 35),
              Text(
                "@${user?.username}",
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        );
  }

  void _defaultAction(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUserPage(username: user?.username ?? ""),));
  }
}