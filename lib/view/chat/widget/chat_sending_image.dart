import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/bloc/chat_bloc.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_time.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class ChatSendingImage extends StatelessWidget {
  final XFile file;
  final bool isError;

  const ChatSendingImage({super.key, required this.file, this.isError = false});

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
            child: InkWell(
              onTap: () {
                context.read<ChatBloc>().add(RescanImageEvent(file));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        color: AssetColor.green50.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: isError
                                ? AssetColor.red100
                                : AssetColor.green50.withOpacity(0.5)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 5,
                              spreadRadius: 0,
                              offset: const Offset(0, 0))
                        ]),
                    child: Opacity(
                        opacity: 0.5, child: Image.file(File(file.path))),
                  ),
                  Column(
                    children: isError
                        ? [
                            SvgPicture.asset(Assets.imagesIcUpload,
                                colorFilter: const ColorFilter.mode(
                                    AssetColor.red100, BlendMode.srcIn)),
                            const SpaceVertical(),
                            const Text(
                              "Failed to scan image, click to retry",
                              style: TextStyle(
                                  fontFamily: poppins,
                                  fontWeight: FontWeight.w600,
                                  color: AssetColor.red100),
                            )
                          ]
                        : const [
                            CircularProgressIndicator(color: Colors.white),
                            SpaceVertical(),
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
          ),
        ],
      ),
    );
  }
}
