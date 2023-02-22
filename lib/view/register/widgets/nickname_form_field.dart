import 'package:flutter/material.dart';
import 'package:vita_client_app/view/widgets/user_form_field.dart';

class NickNameFormField extends StatefulWidget {
  const NickNameFormField({super.key});

  @override
  State<NickNameFormField> createState() => _NickNameFormField();
}

class _NickNameFormField extends State<NickNameFormField> {
  @override
  Widget build(BuildContext context) {
    return UserFormField(label: "Nickname", validator: _validateNickname);
  }

  String? _validateNickname(String? value) {
    if (value != null && value.isEmpty) {
      return "Please fill nickname";
    } else {
      return null;
    }
  }
}
