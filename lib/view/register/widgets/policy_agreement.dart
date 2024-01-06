import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';

class PolicyAgreement extends StatefulWidget {
  final bool isSelected;
  final void Function(bool?)? onChange;

  const PolicyAgreement(
      {super.key, required this.isSelected, required this.onChange});

  @override
  State<PolicyAgreement> createState() => _PolicyAgreement();
}

class _PolicyAgreement extends State<PolicyAgreement> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(0),
      controlAffinity: ListTileControlAffinity.leading,
      value: widget.isSelected,
      onChanged: widget.onChange,
      checkboxShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      title: RichText(
        text: TextSpan(
          text: AppLocalizations.of(context)!.textAgreeTo,
          style: Theme.of(context).textTheme.bodyMedium,
          children: <TextSpan>[
            TextSpan(
                text: AppLocalizations.of(context)!.textUserAgreement,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Todo: show dialog user agreement
                  },
                style: const TextStyle(
                    color: AssetColor.blue200, fontWeight: FontWeight.w600)),
            TextSpan(text: AppLocalizations.of(context)!.textAnd),
            TextSpan(
                text: AppLocalizations.of(context)!.textPrivacyPolicy,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Todo: show dialog user privacy policy
                  },
                style: const TextStyle(
                    color: AssetColor.blue200, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
