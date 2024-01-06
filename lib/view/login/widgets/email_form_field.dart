import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/view/widgets/input_border.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class EmailFormField extends StatefulWidget {
  final Function(String?)? onSave;

  const EmailFormField({super.key, this.onSave});

  @override
  State<EmailFormField> createState() => _EmailFormField();
}

class _EmailFormField extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.textEmail,
            style: Theme.of(context).textTheme.labelMedium),
        const SpaceVertical(),
        TextFormField(
          onSaved: widget.onSave,
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: _validateEmail,
        )
      ],
    );
  }

  String? _validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty && !regex.hasMatch(value)
        ? AppLocalizations.of(context)!.textEmptyEmail
        : null;
  }
}
