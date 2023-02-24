import 'package:flutter/material.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';

class Alert extends StatelessWidget {
  final Color background;
  final Color border;
  final Widget? icon;
  final Widget? child;
  final String? text;
  final Color textColor;

  const Alert(
      {super.key,
      required this.background,
      required this.border,
      this.icon,
      this.child,
      this.text,
      this.textColor = AssetColor.textBlack});

  const Alert.danger(
      {super.key,
      this.background = AssetColor.red50,
      this.border = AssetColor.red100,
      this.icon,
      this.child,
      this.text,
      this.textColor = AssetColor.red200});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: border)),
      child: Row(
        children: [
          if (icon != null) icon!,
          if (child != null) child!,
          if (text != null)
            Flexible(
              child: Text(
                text!,
                style: TextStyle(color: textColor, fontSize: 14),
              ),
            )
        ],
      ),
    );
  }
}
