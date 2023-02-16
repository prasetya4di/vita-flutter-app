import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/util/constant/routes.dart';
import 'package:vita_client_app/view/splash/bloc/splash_bloc.dart';
import 'package:vita_client_app/view/splash/bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<SplashBloc>().add(const GetMessageEvent()));

    return BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("I <3 Pras"),
            if (state is SplashLoadingState) const CircularProgressIndicator(),
            if (state is SplashLoadingState)
              Text(
                AppLocalizations.of(context).fetchingInformation,
                style: Theme.of(context).textTheme.titleMedium,
              )
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is SplashLoadedState) {
        Navigator.pushReplacementNamed(context, Routes.chat);
      }
    });
  }
}
