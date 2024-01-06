import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/view/widgets/user_form_field.dart';

class FirstNameFormField extends StatefulWidget {
  final Function(String?)? onSave;

  const FirstNameFormField({super.key, this.onSave});

  @override
  State<FirstNameFormField> createState() => _FirstNameFormField();
}

class _FirstNameFormField extends State<FirstNameFormField> {
  @override
  Widget build(BuildContext context) {
    return UserFormField(
      label: AppLocalizations.of(context)!.textFirstName,
      validator: _validateFirstName,
      onSave: widget.onSave,
    );
  }

  String? _validateFirstName(String? value) {
    if (value != null && value.isEmpty) {
      return AppLocalizations.of(context)!.textEmptyFirstName;
    } else {
      return null;
    }
  }
}
