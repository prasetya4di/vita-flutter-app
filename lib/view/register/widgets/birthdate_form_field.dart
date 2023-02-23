import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/view/widgets/user_form_field.dart';

class BirthdateFormField extends StatefulWidget {
  final Function(String?)? onSave;

  const BirthdateFormField({super.key, this.onSave});

  @override
  State<BirthdateFormField> createState() => _BirthdateFormField();
}

class _BirthdateFormField extends State<BirthdateFormField> {
  final TextEditingController _birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UserFormField(
      onSave: widget.onSave,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now());
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);

          setState(() {
            _birthdateController.text = formattedDate;
          });
        }
      },
      controller: _birthdateController,
      readOnly: true,
      label: AppLocalizations.of(context).textBirthday,
      validator: _validateBirthdate,
      suffix: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: null,
          icon: SvgPicture.asset(Assets.imagesIcCalendar)),
    );
  }

  String? _validateBirthdate(String? value) {
    if (value != null && value.isEmpty) {
      return AppLocalizations.of(context).textEmptyBirthday;
    } else {
      return null;
    }
  }
}
