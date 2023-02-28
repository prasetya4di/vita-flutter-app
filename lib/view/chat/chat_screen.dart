import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart';
import 'package:vita_client_app/data/model/request/upload_image.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/util/constant/routes.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/bloc/chat_bloc.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';
import 'package:vita_client_app/view/chat/widget/chat_possibilities.dart';
import 'package:vita_client_app/view/chat/widget/chat_reply.dart';
import 'package:vita_client_app/view/chat/widget/chat_reply_sending.dart';
import 'package:vita_client_app/view/chat/widget/chat_send.dart';
import 'package:vita_client_app/view/chat/widget/chat_send_image.dart';
import 'package:vita_client_app/view/chat/widget/chat_sending.dart';
import 'package:vita_client_app/view/chat/widget/chat_sending_image.dart';
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
                  Navigator.of(context).pushNamed(Routes.profile);
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
              return SafeArea(
                child: Column(
                  children: [
                    Flexible(
                        child: ListView.builder(
                            reverse: true,
                            itemCount: context.read<ChatBloc>().messages.length,
                            itemBuilder: (context, i) {
                              var data = context.read<ChatBloc>().messages[i];
                              if (data is Message) {
                                if (data.messageType == "reply") {
                                  return ChatReply(message: data);
                                } else if (data.fileType == "image") {
                                  return ChatSendImage(message: data);
                                } else {
                                  return ChatSend(message: data);
                                }
                              } else if (data is SendMessage) {
                                return ChatSending(
                                    message: data.message,
                                    isError: data.isError);
                              } else if (data is XFile) {
                                return ChatSendingImage(file: data);
                              } else if (data is UploadImage) {
                                return ChatSendingImage(
                                    file: data.image, isError: data.isError);
                              } else if (data is List<ImagePossibility>) {
                                return ChatPossibilities(
                                    possibilities: data,
                                    onSelect: (data) {
                                      context.read<ChatBloc>().add(
                                          ChatEvent.onReplyMessage(
                                              data.description));
                                    });
                              } else if (data is ReplyMessage) {
                                return ChatReplySending(message: data.message);
                              }
                              return null;
                            })),
                    ChatTextField(controller: _controller)
                  ],
                ),
              );
            }));
  }
}
