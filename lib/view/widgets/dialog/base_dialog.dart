import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/widgets/text_title.dart';

class BaseDialog extends StatelessWidget {
  final String? title;
  final Widget child;
  final void Function()? onCloseTap;

  const BaseDialog(
      {Key? key, required this.title, required this.child, this.onCloseTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: AssetColor.ghostWhite),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextTitle.large(text: title ?? "Alert"),
                    InkWell(
                      onTap: onCloseTap ??
                          () {
                            Navigator.pop(context);
                          },
                      child: const Icon(Icons.clear, size: 18),
                    )
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: child,
              )
            ],
          ),
        ),
      ),
    );
  }
}
