import 'package:flutter/material.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';

class TextTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final double letterSpacing;
  final int? maxLines;
  final TextAlign? textAlign;

  const TextTitle(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w800,
      this.textColor = AssetColor.textBlack,
      this.letterSpacing = 0.5,
      this.maxLines,
      this.textAlign})
      : super(key: key);

  const TextTitle.small(
      {Key? key,
      required this.text,
      this.fontSize = 12,
      this.fontWeight = FontWeight.w800,
      this.textColor = AssetColor.textBlack,
      this.letterSpacing = 0.5,
      this.maxLines,
      this.textAlign})
      : super(key: key);

  const TextTitle.medium(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w800,
      this.textColor = AssetColor.textBlack,
      this.letterSpacing = 0.5,
      this.maxLines,
      this.textAlign})
      : super(key: key);

  const TextTitle.large(
      {Key? key,
      required this.text,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w800,
      this.textColor = AssetColor.textBlack,
      this.letterSpacing = 0.5,
      this.maxLines,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
            letterSpacing: letterSpacing));
  }
}
