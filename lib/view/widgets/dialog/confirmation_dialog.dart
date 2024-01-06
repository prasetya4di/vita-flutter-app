import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/view/widgets/dialog/base_dialog.dart';
import 'package:vita_client_app/view/widgets/space_horizontal.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

Future<bool> showConfirmationDialog(
    BuildContext context, String message) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return BaseDialog(
            onCloseTap: () {
              Navigator.pop(context, false);
            },
            title: AppLocalizations.of(context)!.textConfirmation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message),
                const SpaceVertical(size: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(AppLocalizations.of(context)!.textNo),
                      ),
                    ),
                    const SpaceHorizontal(),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text(AppLocalizations.of(context)!.textYes)),
                    )
                  ],
                )
              ],
            ));
      });
}
