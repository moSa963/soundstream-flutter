import 'package:flutter/material.dart';
import 'package:soundstream_flutter/utils/validator.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
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
              //Name field
              TextFormField(
                onChanged: (value) => _onChanged("name", value),
                decoration: _inputDecoration("name"),
                validator: (v) => Validator.validate(v,
                    max: 255,
                    min: 3,
                    regex: r"^[A-Za-z]+([._-]?[A-Za-z0-9]+)*$"),
              ),
              const SizedBox(height: 20),
              //Username field
              TextFormField(
                onChanged: (value) => _onChanged("username", value),
                decoration: _inputDecoration("username"),
                validator: (v) => Validator.validate(v,
                    max: 255,
                    min: 3,
                    regex: r"^[A-Za-z]+([ ._-]?[A-Za-z0-9]+)*$"),
              ),
              const SizedBox(height: 20),
              //Email field
              TextFormField(
                onChanged: (value) => _onChanged("email", value),
                decoration: _inputDecoration("email"),
                validator: (v) => Validator.validate(v,
                    max: 255,
                    min: 3,
                    regex:
                        r"^[a-zA-z]+([._]?[a-zA-z0-9]+)*[@][a-zA-z]+[.][a-zA-z]+$"),
              ),
              const SizedBox(height: 20),
              //Password field
              TextFormField(
                onChanged: (value) => _onChanged("password", value),
                obscureText: true,
                decoration: _inputDecoration("password"),
                validator: (v) => Validator.validate(v, min: 8),
              ),
              const SizedBox(height: 20),
              //confirm password field
              TextFormField(
                onChanged: (value) => _onChanged("confirm_password", value),
                obscureText: true,
                decoration: _inputDecoration("confirm password"),
                validator: (v) =>
                    Validator.validate(v, min: 8, equal: inputs["password"]),
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
      child: FilledButton(onPressed: _handelSubmit, child: const Text("Sign up")),
    );
  }

  void _onChanged(String key, String value) {
    inputs.update(key, (_) => value, ifAbsent: () => value);
  }

  void _handelSubmit() {
    if (!(_key.currentState?.validate() ?? false)) return;

    //TODO
  }
}
