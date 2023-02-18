import 'package:flutter/material.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_time.dart';

class ChatReplySending extends StatelessWidget {
  final String message;

  const ChatReplySending({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  color: AssetColor.gray100.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 0))
                  ]),
              child: Text(
                message,
                style: TextStyle(
                    fontFamily: poppins, color: Colors.black.withOpacity(0.5)),
              ),
            ),
          ),
          ChatTextTime(time: DateTime.now()),
        ],
      ),
    );
  }
}
