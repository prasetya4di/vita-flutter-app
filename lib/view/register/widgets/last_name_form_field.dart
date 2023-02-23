import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/view/widgets/user_form_field.dart';

class LastNameFormField extends StatefulWidget {
  final Function(String?)? onSave;

  const LastNameFormField({super.key, this.onSave});

  @override
  State<LastNameFormField> createState() => _LastNameFormField();
}

class _LastNameFormField extends State<LastNameFormField> {
  @override
  Widget build(BuildContext context) {
    return UserFormField(
      label: AppLocalizations.of(context).textLastName,
      validator: _validateLastName,
      onSave: widget.onSave,
    );
  }

  String? _validateLastName(String? value) {
    if (value != null && value.isEmpty) {
      return AppLocalizations.of(context).textEmptyLastName;
    } else {
      return null;
    }
  }
}
