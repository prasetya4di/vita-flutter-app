import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_time.dart';

class ChatSend extends StatelessWidget {
  final Message message;

  const ChatSend({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ChatTextTime(time: message.createdDate),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  color: AssetColor.green50,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 0))
                  ]),
              child: MarkdownBody(
                data: message.message,
                selectable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
