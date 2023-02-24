import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/util/constant/routes.dart';
import 'package:vita_client_app/view/login/widgets/email_form_field.dart';
import 'package:vita_client_app/view/login/widgets/register_button.dart';
import 'package:vita_client_app/view/register/bloc/register_bloc.dart';
import 'package:vita_client_app/view/register/bloc/register_state.dart';
import 'package:vita_client_app/view/register/widgets/birthdate_form_field.dart';
import 'package:vita_client_app/view/register/widgets/first_name_form_field.dart';
import 'package:vita_client_app/view/register/widgets/last_name_form_field.dart';
import 'package:vita_client_app/view/register/widgets/nickname_form_field.dart';
import 'package:vita_client_app/view/register/widgets/passwords_form_field.dart';
import 'package:vita_client_app/view/register/widgets/policy_agreement.dart';
import 'package:vita_client_app/view/widgets/alert.dart';
import 'package:vita_client_app/view/widgets/dialog/loading_dialog.dart';
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

  String _email = "";
  String _password = "";
  String _firstname = "";
  String _lastname = "";
  String _nickname = "";
  DateTime _birthday = DateTime.now();

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
          child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
            LoadingDialog.hideLoading(context, Routes.register);
            if (state is RegisterLoadingState) {
              LoadingDialog.showLoading(context);
            } else if (state is RegisterSuccessState) {
              Navigator.pushReplacementNamed(context, Routes.chat);
            }
          }, builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const ImageLogo(),
                    EmailFormField(onSave: (value) {
                      _email = value ?? "";
                    }),
                    const SpaceVertical(),
                    FirstNameFormField(onSave: (value) {
                      _firstname = value ?? "";
                    }),
                    const SpaceVertical(),
                    LastNameFormField(onSave: (value) {
                      _lastname = value ?? "";
                    }),
                    const SpaceVertical(),
                    NicknameFormField(onSave: (value) {
                      _nickname = value ?? "";
                    }),
                    const SpaceVertical(),
                    BirthdateFormField(
                      onchange: (value) {
                        _birthday = value;
                      },
                    ),
                    const SpaceVertical(),
                    PasswordsFormField(onSave: (value) {
                      _password = value ?? "";
                    }),
                    const SpaceVertical(),
                    PolicyAgreement(
                        isSelected: _isAgreeToPrivacyPolicy,
                        onChange: (value) {
                          setState(() {
                            _isAgreeToPrivacyPolicy = !_isAgreeToPrivacyPolicy;
                          });
                        }),
                    const SpaceVertical(size: 16),
                    if (state is RegisterErrorState)
                      Alert.danger(text: state.message),
                    if (state is RegisterErrorState)
                      const SpaceVertical(size: 16),
                    RegisterButton(
                        enabled: _isAgreeToPrivacyPolicy,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            context.read<RegisterBloc>().add(PostRegisterEvent(
                                RegisterRequest(_email, _password, _firstname,
                                    _lastname, _nickname, _birthday.toUtc())));
                          }
                        })
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
