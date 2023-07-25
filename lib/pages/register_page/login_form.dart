import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundstream_flutter/models/api_service_exaption.dart';
import 'package:soundstream_flutter/providers/auth_provider.dart';
import 'package:soundstream_flutter/utils/validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onError});
  final void Function(String error) onError; 

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _key = GlobalKey<FormState>();
  final Map<String, String> inputs = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //Username field
              TextFormField(
                onChanged: (value) => _onChanged("username", value),
                decoration: _inputDecoration("username"),
                validator: (v) => Validator.validate(v,
                    max: 255,
                    min: 3,
                    regex: r"^[A-Za-z]+([ ._-]?[A-Za-z0-9]+)*$"),
              ),
              const SizedBox(height: 25),
              //Password field
              TextFormField(
                onChanged: (value) => _onChanged("password", value),
                obscureText: true,
                decoration: _inputDecoration("password"),
                validator: (v) => Validator.validate(v, min: 8),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        _submitButton(),
      ],
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      label: Text(label),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: FilledButton(onPressed: _handelSubmit, child: const Text("Login")),
    );
  }

  void _onChanged(String key, String value) {
    inputs.update(key, (_) => value, ifAbsent: () => value);
  }

  void _handelSubmit() async {
    if (!(_key.currentState?.validate() ?? false)) return;

    try {
      await context.read<AuthProvider>().login(
            username: inputs["username"] ?? "",
            password: inputs["password"] ?? "",
          );
    } on ApiServiceExaption catch (e) {
      widget.onError.call(e.message);
    }
  }
}
