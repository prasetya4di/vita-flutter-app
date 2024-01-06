import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/profile/bloc/profile_bloc.dart';
import 'package:vita_client_app/view/profile/bloc/profile_state.dart';
import 'package:vita_client_app/view/widgets/dialog/confirmation_dialog.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showConfirmationDialog(
                context, AppLocalizations.of(context)!.textLogoutConfirmation)
            .then((value) {
          if (value) {
            context.read<ProfileBloc>().add(const LogoutEvent());
          }
        });
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          padding: const EdgeInsets.all(12),
          backgroundColor: AssetColor.red100),
      child: Text(
        AppLocalizations.of(context)!.textLogout,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: poppins,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
