import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/chat/widget/chat_text_time.dart';

class ChatPossibilities extends StatefulWidget {
  final List<ImagePossibility> possibilities;
  final Function(ImagePossibility) onSelect;

  const ChatPossibilities(
      {super.key, required this.possibilities, required this.onSelect});

  @override
  State<ChatPossibilities> createState() => _ChatPossibilities();
}

class _ChatPossibilities extends State<ChatPossibilities> {
  ImagePossibility? _selectedPossibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  color: AssetColor.gray100,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 0))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context).textPossibilitiesFound,
                      style: Theme.of(context).textTheme.bodyMedium),
                  _buildRadioPossibility(),
                  MaterialButton(
                    color: Colors.blue,
                    disabledColor: AssetColor.gray200,
                    onPressed: _selectedPossibility == null
                        ? null
                        : () {
                            widget.onSelect(_selectedPossibility!);
                          },
                    child: Text(
                      AppLocalizations.of(context).textSelect,
                      style: const TextStyle(
                          fontFamily: poppins,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          ChatTextTime(time: DateTime.now()),
        ],
      ),
    );
  }

  Widget _buildRadioPossibility() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.possibilities
          .map((e) => ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  setState(() {
                    if (e == _selectedPossibility) {
                      _selectedPossibility = null;
                    } else {
                      _selectedPossibility = e;
                    }
                  });
                },
                title: Text(e.description,
                    style: Theme.of(context).textTheme.bodyMedium),
                leading: Radio<ImagePossibility>(
                  groupValue: _selectedPossibility,
                  value: e,
                  onChanged: (value) {
                    setState(() {
                      _selectedPossibility = value!;
                    });
                  },
                ),
              ))
          .toList(),
    );
  }
}
