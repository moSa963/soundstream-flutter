import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/pages/register_page/login_form.dart';
import 'package:soundstream_flutter/pages/register_page/signup_form.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/widgets/loading_box.dart';
import 'package:soundstream_flutter/widgets/logo_banner.dart';
import 'package:soundstream_flutter/widgets/button/text_scale_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: LogoBanner(
                          title: "SoundStream",
                          maxHeight: 100,
                          direction:
                              _index == 0 ? Axis.vertical : Axis.horizontal),
                    ),
                  ),
                  _getForm()
                ],
              ),
            ),
            _navText()
          ],
        ),
      ),
    );
  }

  Widget _getForm() {
    if (context.watch<AuthProvider>().loading) {
      return const LoadingBox();
    }

    switch (_index) {
      case 1:
        return SignupForm(onError: handleError);
      default:
        return LoginForm(onError: handleError);
    }
  }

  Widget _navText() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          Text("you${_index == 0 ? " dont " : " "}have an account? "),
          TextScaleButton(
            _index == 0 ? " sign up" : " login",
            onTap: () {
              setState(() {
                _index = _index == 1 ? 0 : 1;
              });
            },
          ),
        ],
      ),
    );
  }

  void handleError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }
}
