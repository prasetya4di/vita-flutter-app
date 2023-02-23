import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingDialog {
  static showLoading(BuildContext context,
      {String? message, Widget? child, bool useCircularProgress = true}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                height: 64.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (useCircularProgress) const CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: child ??
                          Text(
                            message ?? AppLocalizations.of(context).textLoading,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static hideLoading(BuildContext context, String pageName) {
    Navigator.popUntil(context, ModalRoute.withName(pageName));
  }
}
