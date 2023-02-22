import 'package:flutter/material.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';
import 'package:vita_client_app/view/widgets/user_form_field.dart';

class PasswordsFormField extends StatefulWidget {
  const PasswordsFormField({super.key});

  @override
  State<PasswordsFormField> createState() => _PasswordsFormField();
}

class _PasswordsFormField extends State<PasswordsFormField> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserFormField(
            obscureText: true,
            label: "Password",
            controller: _passwordController,
            validator: _validatePassword),
        const SpaceVertical(),
        UserFormField(
            obscureText: true,
            label: "Repeat Password",
            controller: _repeatPasswordController,
            validator: _validateRepeatPassword)
      ],
    );
  }

  String? _validatePassword(String? value) {
    final regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (value != null && value.isEmpty) {
      return "Please enter a password";
    } else if (value!.length < 8) {
      return "Please enter at least 8 characters";
    } else if (!regex.hasMatch(value)) {
      return "Password should contain at least one uppercase, \nlowercase, number, and a special character.";
    } else {
      return null;
    }
  }

  String? _validateRepeatPassword(String? value) {
    if (value != null && value.isEmpty) {
      return "Please repeat your password";
    } else if (value != _passwordController.value.text) {
      return "Please enter the same password";
    } else {
      return null;
    }
  }
}
