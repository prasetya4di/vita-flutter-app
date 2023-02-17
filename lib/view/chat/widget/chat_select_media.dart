import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';

class ChatSelectMedia extends StatefulWidget {
  final Function() onTap;
  final Function(ImageSource) onSelect;

  const ChatSelectMedia(
      {super.key, required this.onTap, required this.onSelect});

  @override
  State<ChatSelectMedia> createState() => _ChatSelectMedia();
}

class _ChatSelectMedia extends State<ChatSelectMedia> {
  GlobalKey overlayKey = LabeledGlobalKey("button_icon");
  late OverlayEntry overlayEntry;
  late Size buttonSize;
  late Offset buttonPosition;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
  }

  findButton() {
    RenderBox renderBox =
        overlayKey.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void openMenu(BuildContext context) {
    findButton();
    overlayEntry = overlayEntryBuilder();
    Overlay.of(context).insert(overlayEntry);
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  void closeMenu() {
    overlayEntry.remove();
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: overlayKey,
      icon: SvgPicture.asset(Assets.imagesIcGallery,
          colorFilter: ColorFilter.mode(
              isMenuOpen ? Colors.black : AssetColor.gray200, BlendMode.srcIn)),
      onPressed: () {
        widget.onTap();
        if (!isMenuOpen) {
          openMenu(context);
        } else {
          closeMenu();
        }
      },
    );
  }

  OverlayEntry overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 555,
          left: buttonPosition.dx - (buttonSize.width / 2) - 32,
          child: Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            child: Row(
              children: [
                mediaButton(
                    Assets.imagesIcCamera, AppLocalizations.of(context).camera,
                    () {
                  widget.onSelect(ImageSource.camera);
                }),
                mediaButton(Assets.imagesIcGallery,
                    AppLocalizations.of(context).gallery, () {
                  widget.onSelect(ImageSource.gallery);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget mediaButton(String asset, String text, Function() onClick) {
    return GestureDetector(
      onTap: () {
        closeMenu();
        onClick();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            SvgPicture.asset(asset),
            Text(text, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      ),
    );
  }
}
