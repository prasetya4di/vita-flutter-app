import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_time.dart';

class ChatSendingImage extends StatelessWidget {
  final XFile file;

  const ChatSendingImage({super.key, required this.file});

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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      color: AssetColor.green50.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 5,
                            spreadRadius: 0,
                            offset: const Offset(0, 0))
                      ]),
                  child:
                      Opacity(opacity: 0.5, child: Image.file(File(file.path))),
                ),
                Column(
                  children: const [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      "Scanning image ....",
                      style: TextStyle(
                          fontFamily: poppins,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
