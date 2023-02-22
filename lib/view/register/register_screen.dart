import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/view/login/widgets/email_form_field.dart';
import 'package:vita_client_app/view/login/widgets/register_button.dart';
import 'package:vita_client_app/view/register/widgets/birthdate_form_field.dart';
import 'package:vita_client_app/view/register/widgets/first_name_form_field.dart';
import 'package:vita_client_app/view/register/widgets/last_name_form_field.dart';
import 'package:vita_client_app/view/register/widgets/nickname_form_field.dart';
import 'package:vita_client_app/view/register/widgets/passwords_form_field.dart';
import 'package:vita_client_app/view/register/widgets/policy_agreement.dart';
import 'package:vita_client_app/view/widgets/image_logo.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isAgreeToPrivacyPolicy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: Text(AppLocalizations.of(context).textSignUp,
            style: Theme.of(context).textTheme.labelLarge),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
                  const SpaceVertical(),
                  const FirstNameFormField(),
                  const SpaceVertical(),
                  const LastNameFormField(),
                  const SpaceVertical(),
                  const NicknameFormField(),
                  const SpaceVertical(),
                  const BirthdateFormField(),
                  const SpaceVertical(),
                  const PasswordsFormField(),
                  const SpaceVertical(),
                  PolicyAgreement(
                      isSelected: _isAgreeToPrivacyPolicy,
                      onChange: (value) {
                        setState(() {
                          _isAgreeToPrivacyPolicy = !_isAgreeToPrivacyPolicy;
                        });
                      }),
                  const SpaceVertical(size: 16),
                  RegisterButton(
                      enabled: _isAgreeToPrivacyPolicy,
                      onPressed: () {
                        if (!(_formKey.currentState?.validate() ?? false)) {}
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
