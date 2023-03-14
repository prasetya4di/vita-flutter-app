import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/view/widgets/input_border.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class PasswordFormField extends StatefulWidget {
  final Function(String?)? onSave;

  const PasswordFormField({super.key, this.onSave});

  @override
  State<PasswordFormField> createState() => _PasswordFormField();
}

class _PasswordFormField extends State<PasswordFormField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).textPassword,
            style: Theme.of(context).textTheme.labelMedium),
        const SpaceVertical(),
        TextFormField(
          onSaved: widget.onSave,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !isVisible,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: SvgPicture.asset(
                    isVisible ? Assets.imagesIcEye : Assets.imagesIcEyeSlash),
              )),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: _validatePassword,
        )
      ],
    );
  }

  String? _validatePassword(String? value) {
    return value!.isEmpty
        ? AppLocalizations.of(context).textEmptyPassword
        : null;
  }
}
