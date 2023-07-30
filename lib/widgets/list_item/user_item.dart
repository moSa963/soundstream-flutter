import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/pages/user_page/show_user_page.dart';
import 'package:soundstream_flutter/widgets/list_item/list_item.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: () => _openShowUserPage(context),
      leading: AspectRatio(aspectRatio: 1, child: Hero(tag: user.username, child: Image.network(user.imgUri.toString(), fit: BoxFit.cover,))),
      title: user.name,
      subtitle: "@${user.username}"
    );
  }

  void _openShowUserPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUserPage(username: user.username),));
  }
}
