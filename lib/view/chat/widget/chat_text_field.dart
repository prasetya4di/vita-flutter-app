import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/bloc/chat_bloc.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';
import 'package:vita_client_app/view/chat/widget/chat_select_media.dart';

class ChatTextField extends StatefulWidget {
  final TextEditingController controller;

  const ChatTextField({super.key, required this.controller});

  @override
  State<ChatTextField> createState() => _ChatTextField();
}

class _ChatTextField extends State<ChatTextField> {
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
              offset: const Offset(0, -8))
        ]),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: widget.controller,
                onChanged: (text) {
                  setState(() {});
                },
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: null,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 18),
                    hintText: AppLocalizations.of(context)!.typeMessage,
                    hintStyle: const TextStyle(
                        color: AssetColor.gray200,
                        fontFamily: poppins,
                        fontSize: 14),
                    fillColor: AssetColor.gray100,
                    filled: true,
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    suffixIcon: ChatSelectMedia(
                      onTap: () {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          widget.controller.clear();
                        });
                      },
                      onSelect: (source) {
                        context.read<ChatBloc>().add(ScanImageEvent(source));
                      },
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextButton(
                  onPressed: widget.controller.value.text.isEmpty
                      ? null
                      : () {
                          context.read<ChatBloc>().add(
                              SendMessageEvent(widget.controller.value.text));
                          setState(() {
                            FocusScope.of(context).unfocus();
                            widget.controller.clear();
                          });
                        },
                  child: Text(
                    AppLocalizations.of(context)!.sendButton,
                    style: const TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
