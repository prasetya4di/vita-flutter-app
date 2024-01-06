import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/view/widgets/user_form_field.dart';

class NicknameFormField extends StatefulWidget {
  final Function(String?)? onSave;

  const NicknameFormField({super.key, this.onSave});

  @override
  State<NicknameFormField> createState() => _NickNameFormField();
}

class _NickNameFormField extends State<NicknameFormField> {
  @override
  Widget build(BuildContext context) {
    return UserFormField(
      label: AppLocalizations.of(context)!.textNickname,
      validator: _validateNickname,
      onSave: widget.onSave,
    );
  }

  String? _validateNickname(String? value) {
    if (value != null && value.isEmpty) {
      return AppLocalizations.of(context)!.textEmptyNickname;
    } else {
      return null;
    }
  }
}
