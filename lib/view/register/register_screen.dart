import 'package:flutter/material.dart';
import 'package:vita_client_app/view/login/widgets/email_form_field.dart';
import 'package:vita_client_app/view/login/widgets/register_button.dart';
import 'package:vita_client_app/view/widgets/image_logo.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const ImageLogo(),
                  const EmailFormField(),
                  const SpaceVertical(size: 16),
                  RegisterButton(onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
