import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vita", style: Theme.of(context).textTheme.titleMedium),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white60,
              ),
              width: 265,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: const InputDecoration(fillColor: Colors.grey),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context).sendButton))
          ],
        ),
      ),
    );
  }
}
