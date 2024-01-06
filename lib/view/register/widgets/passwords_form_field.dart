import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';
import 'package:vita_client_app/view/widgets/user_form_field.dart';

class PasswordsFormField extends StatefulWidget {
  final Function(String?)? onSave;

  const PasswordsFormField({super.key, this.onSave});

  @override
  State<PasswordsFormField> createState() => _PasswordsFormField();
}

class _PasswordsFormField extends State<PasswordsFormField> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool isRepeatPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserFormField(
            suffix: _eyeIcon(isPasswordVisible, (value) {
              setState(() {
                isPasswordVisible = value;
              });
            }),
            onSave: widget.onSave,
            obscureText: !isPasswordVisible,
            label: AppLocalizations.of(context)!.textPassword,
            controller: _passwordController,
            validator: _validatePassword),
        const SpaceVertical(),
        UserFormField(
            suffix: _eyeIcon(isRepeatPasswordVisible, (value) {
              setState(() {
                isRepeatPasswordVisible = value;
              });
            }),
            obscureText: !isRepeatPasswordVisible,
            label: AppLocalizations.of(context)!.textRepeatPassword,
            controller: _repeatPasswordController,
            validator: _validateRepeatPassword)
      ],
    );
  }

  Widget _eyeIcon(bool isVisible, Function(bool) onPressed) {
    return IconButton(
      onPressed: () {
        onPressed(!isVisible);
      },
      icon: SvgPicture.asset(
          isVisible ? Assets.imagesIcEye : Assets.imagesIcEyeSlash),
    );
  }

  String? _validatePassword(String? value) {
    final regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (value != null && value.isEmpty) {
      return AppLocalizations.of(context)!.textEmptyPassword;
    } else if (value!.length < 8) {
      return AppLocalizations.of(context)!.textPasswordMinimum;
    } else if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.textPasswordMustContain;
    } else {
      return null;
    }
  }

  String? _validateRepeatPassword(String? value) {
    if (value != null && value.isEmpty) {
      return AppLocalizations.of(context)!.textEmptyRepeatPassword;
    } else if (value != _passwordController.value.text) {
      return AppLocalizations.of(context)!.textIncorrectRepeatPassword;
    } else {
      return null;
    }
  }
}
