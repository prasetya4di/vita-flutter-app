import 'package:flutter/material.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_time.dart';

class ChatSending extends StatelessWidget {
  final String message;

  const ChatSending({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ChatTextTime(time: DateTime.now()),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 8),
              decoration: const BoxDecoration(
                  color: AssetColor.green50,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                message,
                style:
                    const TextStyle(fontFamily: poppins, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
