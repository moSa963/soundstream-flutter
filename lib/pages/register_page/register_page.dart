import 'package:flutter/material.dart';
import 'package:soundstream_flutter/pages/register_page/login_form.dart';
import 'package:soundstream_flutter/pages/register_page/signup_form.dart';
import 'package:soundstream_flutter/widgets/logo_banner.dart';
import 'package:soundstream_flutter/widgets/button/text_scale_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  final List<Widget> forms = [
    const LoginForm(),
    const SignupForm(),
  ];

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LogoBanner(title: "SoundStream", direction: _index == 1 ? Axis.horizontal : Axis.vertical, maxHeight: 100),
            widget.forms[_index],
            _navText(),
          ],
        ),
      ),
    );
  }

  Widget _navText() {
    return Container(
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          Text("you${_index == 0 ? " dont " : " "}have an account? "),
          TextScaleButton(_index == 0 ? " sign up" : " login", onTap: () {
            setState(() {
              _index = _index == 1 ? 0 : 1;
            });
          },),
        ],
      ),
    );
  }
}
