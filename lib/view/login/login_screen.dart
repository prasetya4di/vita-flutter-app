import 'package:flutter/material.dart';
import 'package:vita_client_app/view/login/widgets/email_form_field.dart';
import 'package:vita_client_app/view/login/widgets/password_form_field.dart';
import 'package:vita_client_app/view/widgets/image_logo.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: const [
                ImageLogo(),
                SpaceVertical(),
                EmailFormField(),
                SpaceVertical(),
                SpaceVertical(),
                PasswordFormField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
