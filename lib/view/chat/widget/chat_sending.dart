import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/bloc/chat_bloc.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_time.dart';

class ChatSending extends StatelessWidget {
  final String message;
  final bool isError;

  const ChatSending({super.key, required this.message, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isError) SvgPicture.asset(Assets.imagesIcInfoError),
              if (isError)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Text(
                    AppLocalizations.of(context)!.sendMessageFailed,
                    style:
                        const TextStyle(color: AssetColor.red100, fontSize: 8),
                  ),
                ),
              ChatTextTime(time: DateTime.now()),
            ],
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                if (isError) {
                  context.read<ChatBloc>().add(ResendMessageEvent(message));
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        color: AssetColor.green50,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: isError
                                ? AssetColor.red100
                                : AssetColor.green50)),
                    child: Text(
                      message,
                      style: const TextStyle(
                          fontFamily: poppins, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
