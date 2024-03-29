import 'package:flutter/material.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/widgets/space_vertical.dart';

class ProfileInfo extends StatelessWidget {
  final String label;
  final String text;

  const ProfileInfo({super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: AssetColor.gray100),
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
        const SpaceVertical(size: 16)
      ],
    );
  }
}
