import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/widget/chat_reply.dart';
import 'package:vita_client_app/view/chat/widget/chat_send.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vita", style: Theme.of(context).textTheme.titleMedium),
          actions: [
            IconButton(
                onPressed: () {
                  //Todo add function navigate to profile
                },
                icon: SvgPicture.asset(Assets.imagesIcUser))
          ],
          backgroundColor: AssetColor.gray50,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
        body: Column(
          children: const [
            Expanded(child: Text("Chat message")),
            ChatSend(message: "This is just a test message lohh"),
            ChatReply(message: "Iyaa tauuu, apaan luu !!!!!"),
            ChatSend(message: "This is just a test message lohh"),
            ChatReply(message: "Iyaa tauuu, apaan luu !!!!!"),
            ChatSend(message: "This is just a test message lohh"),
            ChatReply(message: "Iyaa tauuu, apaan luu !!!!!"),
            ChatTextField()
          ],
        ));
  }
}
