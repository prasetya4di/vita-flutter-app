import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/util/constant/routes.dart';
import 'package:vita_client_app/view/login/bloc/login_bloc.dart';
import 'package:vita_client_app/view/login/bloc/login_state.dart';
import 'package:vita_client_app/view/login/widgets/button_separator.dart';
import 'package:vita_client_app/view/login/widgets/email_form_field.dart';
import 'package:vita_client_app/view/login/widgets/login_button.dart';
import 'package:vita_client_app/view/login/widgets/password_form_field.dart';
import 'package:vita_client_app/view/login/widgets/register_button.dart';
import 'package:vita_client_app/view/widgets/image_logo.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const ImageLogo(),
                const SpaceVertical(),
                EmailFormField(onSave: (value) {
                  _email = value ?? "";
                }),
                const SpaceVertical(size: 16),
                PasswordFormField(onSave: (value) {
                  _password = value ?? "";
                }),
                const SpaceVertical(size: 32),
                LoginButton(onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    context
                        .read<LoginBloc>()
                        .add(PostLoginEvent(LoginRequest(_email, _password)));
                  }
                }),
                const SpaceVertical(),
                const ButtonSeparator(),
                const SpaceVertical(),
                RegisterButton(onPressed: () {
                  Navigator.pushNamed(context, Routes.register);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
