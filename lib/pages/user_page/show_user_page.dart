
import 'package:flutter/material.dart';
import 'package:soundstream_flutter/models/user.dart';
import 'package:soundstream_flutter/services/user_service.dart';

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
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(_user?.username ?? "no data"),
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
