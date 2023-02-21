import 'package:flutter/material.dart';
import 'package:vita_client_app/generated/assets.dart';

class ImageLogo extends StatelessWidget {
  final double width;

  const ImageLogo({super.key, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Image(image: const AssetImage(Assets.imagesLogo), width: width);
  }
}
