import 'package:flutter/material.dart';
import 'package:vita_client_app/view/widgets/user_form_field.dart';

class FirstNameFormField extends StatefulWidget {
  const FirstNameFormField({super.key});

  @override
  State<FirstNameFormField> createState() => _FirstNameFormField();
}

class _FirstNameFormField extends State<FirstNameFormField> {
  @override
  Widget build(BuildContext context) {
    return UserFormField(label: "First Name", validator: _validateFirstName);
  }

  String? _validateFirstName(String? value) {
    if (value != null && value.isEmpty) {
      return "Please fill first name";
    } else {
      return null;
    }
  }
}
