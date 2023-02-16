import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/bloc/chat_bloc.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';

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
              offset: const Offset(0, 0))
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
                    hintText: AppLocalizations.of(context).typeMessage,
                    hintStyle: const TextStyle(
                        color: AssetColor.gray200,
                        fontFamily: "Poppins",
                        fontSize: 14),
                    fillColor: AssetColor.gray100,
                    filled: true,
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(Assets.imagesIcGallery,
                          colorFilter: const ColorFilter.mode(
                              AssetColor.gray200, BlendMode.srcIn)),
                      onPressed: () {
                        //Todo implement open image
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
                    AppLocalizations.of(context).sendButton,
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
