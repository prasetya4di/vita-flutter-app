import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    var inputBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AssetColor.gray100));
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, -7))
        ]),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).typeMessage,
                      hintStyle: const TextStyle(
                          color: AssetColor.gray200,
                          fontFamily: "Poppins",
                          fontSize: 14),
                      fillColor: AssetColor.gray100,
                      filled: true,
                      border: inputBorder,
                      enabledBorder: inputBorder)),
            ),
            TextButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context).sendButton))
          ],
        ),
      ),
    );
  }
}
