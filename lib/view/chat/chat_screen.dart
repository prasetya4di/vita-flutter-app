import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/bloc/chat_bloc.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';
import 'package:vita_client_app/view/chat/widget/chat_reply.dart';
import 'package:vita_client_app/view/chat/widget/chat_send.dart';
import 'package:vita_client_app/view/chat/widget/chat_send_image.dart';
import 'package:vita_client_app/view/chat/widget/chat_sending.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<ChatBloc>().add(const LoadMessageEvent()));
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
        backgroundColor: Colors.white,
        body: BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {},
            builder: (context, state) {
              var loadMessage = context.read<ChatBloc>().loadMessage;
              return SafeArea(
                child: Column(
                  children: [
                    Flexible(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: context.read<ChatBloc>().messages.length,
                            itemBuilder: (context, i) {
                              var data = context.read<ChatBloc>().messages[i];
                              if (data.messageType == "reply") {
                                return ChatReply(message: data);
                              } else if (data.fileType == "image") {
                                return ChatSendImage(message: data);
                              } else {
                                return ChatSend(message: data);
                              }
                            })),
                    if (loadMessage != null)
                      ChatSending(message: loadMessage.message),
                    ChatTextField(controller: _controller)
                  ],
                ),
              );
            }));
  }
}
