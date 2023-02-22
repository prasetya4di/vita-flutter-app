import 'package:flutter/material.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

import 'input_border.dart';

class UserFormField extends StatefulWidget {
  final String label;
  final String? Function(String?) validator;
  final TextInputType inputType;

  const UserFormField(
      {super.key,
      required this.label,
      required this.validator,
      this.inputType = TextInputType.text});

  @override
  State<UserFormField> createState() => _UserFormField();
}

class _UserFormField extends State<UserFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.labelMedium),
        const SpaceVertical(),
        TextFormField(
          keyboardType: widget.inputType,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            filled: true,
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
        )
      ],
    );
  }
}
