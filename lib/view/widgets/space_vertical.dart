import 'package:flutter/material.dart';

class SpaceVertical extends StatelessWidget {
  final double size;

  const SpaceVertical({super.key, this.size = 8});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
