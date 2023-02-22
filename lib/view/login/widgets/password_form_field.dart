import 'package:flutter/material.dart';
import 'package:vita_client_app/view/widgets/input_border.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key});

  @override
  State<PasswordFormField> createState() => _PasswordFormField();
}

class _PasswordFormField extends State<PasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Password", style: Theme.of(context).textTheme.labelMedium),
        const SpaceVertical(),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: _validatePassword,
        )
      ],
    );
  }

  String? _validatePassword(String? value) {
    final regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (value != null && value.isEmpty) {
      return "Please fill password";
    } else if (value!.length < 8) {
      return "Please enter at least 8 characters";
    } else if (!regex.hasMatch(value)) {
      return "Password should contain at least one uppercase, \nlowercase, number, and a special character.";
    } else {
      return null;
    }
  }
}
