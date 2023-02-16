import 'package:flutter/material.dart';
import 'package:vita_client_app/view/chat/widget/chat_send.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vita", style: Theme.of(context).textTheme.titleMedium),
        ),
        body: Column(
          children: const [
            Expanded(child: Text("Chat message")),
            ChatSend(message: "This is just a test message lohh"),
            ChatTextField()
          ],
        ));
  }
}
