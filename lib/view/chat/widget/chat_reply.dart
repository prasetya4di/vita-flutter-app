import 'package:flutter/material.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_time.dart';

class ChatReply extends StatelessWidget {
  final String message;

  const ChatReply({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                color: AssetColor.blue200,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: const Offset(0, 0))
                ]),
            child: Text(
              message,
              style: const TextStyle(fontFamily: poppins, color: Colors.white),
            ),
          ),
          const ChatTextTime(time: "11:49"),
        ],
      ),
    );
  }
}
