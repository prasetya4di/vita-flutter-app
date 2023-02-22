import 'package:flutter/material.dart';

class SpaceHorizontal extends StatelessWidget {
  final double size;

  const SpaceHorizontal({super.key, this.size = 8});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}
