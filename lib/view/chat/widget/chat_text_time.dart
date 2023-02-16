import 'package:flutter/material.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';

class ChatTextTime extends StatelessWidget {
  final String time;

  const ChatTextTime({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Text(time,
        style: const TextStyle(
            fontFamily: poppins,
            fontSize: 10,
            color: AssetColor.gray300,
            fontWeight: FontWeight.w600));
  }
}
