import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/services/user_service.dart';
import 'package:soundstream_flutter/widgets/button/navigator_back_button.dart';
import 'package:soundstream_flutter/widgets/fade_shader_mask.dart';

class ShowUserPage extends StatefulWidget {
  const ShowUserPage({super.key, required this.username});
  final String username;
  final _service = const UserService();

  @override
  State<ShowUserPage> createState() => _ShowUserPageState();
}

class _ShowUserPageState extends State<ShowUserPage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Positioned.fill(
                  child: FadeShaderMask(
                    child: _user != null
                        ? Hero(
                            tag: widget.username,
                            child: Image.network(_user?.imgUri.toString() ?? "",
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter))
                        : null,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NavigatorBackButton(),
                      const Spacer(),
                      Text(_user?.username ?? "",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          textScaleFactor: 2,
                          overflow: TextOverflow.ellipsis),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _loadUser() async {
    final user = await widget._service.user(widget.username);
    setState(() {
      _user = user;
    });
  }
}
