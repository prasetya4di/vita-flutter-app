import 'package:flutter/material.dart';

class ButtonSeparator extends StatelessWidget {
  const ButtonSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
            child: Divider(
          color: Colors.black,
          thickness: 2,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Text("or", style: Theme.of(context).textTheme.labelLarge),
        ),
        const Expanded(
            child: Divider(
          color: Colors.black,
          thickness: 2,
        )),
      ],
    );
  }
}
