import 'package:flutter/material.dart';
import 'package:soundstream_flutter/utils/validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

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
    inputs.update(key, (value) => value, ifAbsent: () => value);
  }

  void _handelSubmit() {
    if (!(_key.currentState?.validate() ?? false)) return;

    //TODO
  }
}