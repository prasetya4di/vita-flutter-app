import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:vita_client_app/util/extension/color_extension.dart';
import 'package:vita_client_app/view/profile/bloc/profile_bloc.dart';
import 'package:vita_client_app/view/profile/bloc/profile_state.dart';
import 'package:vita_client_app/view/profile/widgets/profile_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileBloc bloc = context.read<ProfileBloc>();
    bloc.add(const GetProfileEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: AssetColor.gray50,
        shadowColor: Colors.black.withOpacity(0.2),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileInfo(
                    label: AppLocalizations.of(context).textEmail,
                    text: bloc.user?.email ?? ""),
                ProfileInfo(
                    label: AppLocalizations.of(context).textFirstName,
                    text: bloc.user?.firstName ?? ""),
                ProfileInfo(
                    label: AppLocalizations.of(context).textLastName,
                    text: bloc.user?.lastName ?? ""),
                ProfileInfo(
                    label: AppLocalizations.of(context).textNickname,
                    text: bloc.user?.nickname ?? ""),
                ProfileInfo(
                    label: AppLocalizations.of(context).textBirthday,
                    text: DateFormat("dd MMMM yyyy")
                        .format(bloc.user?.birthDate ?? DateTime.now())),
              ],
            ),
          ),
        );
      }),
    );
  }
}
