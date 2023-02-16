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
          const ChatTextTime(time: "11:49"),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  color: AssetColor.green100.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Text(
                message,
                style: TextStyle(
                    fontFamily: poppins, color: Colors.black.withOpacity(0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}