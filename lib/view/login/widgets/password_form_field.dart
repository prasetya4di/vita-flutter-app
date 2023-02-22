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
    return value!.isEmpty ? 'Enter a valid password' : null;
  }
}
