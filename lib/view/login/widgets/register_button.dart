import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/util/constant/font.dart';

class RegisterButton extends StatelessWidget {
  final void Function() onPressed;
  final bool enabled;

  const RegisterButton(
      {super.key, required this.onPressed, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          padding: const EdgeInsets.all(12)),
      child: Text(
        AppLocalizations.of(context)!.textSignUp,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: poppins,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
