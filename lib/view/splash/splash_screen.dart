import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/util/constant/routes.dart';
import 'package:vita_client_app/view/splash/bloc/splash_bloc.dart';
import 'package:vita_client_app/view/splash/bloc/splash_state.dart';
import 'package:vita_client_app/view/widgets/image_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<SplashBloc>().add(const CheckLoginEvent()));

    return BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ImageLogo(),
                if (state is SplashLoadingState)
                  const CircularProgressIndicator(),
                if (state is SplashLoadingState)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.fetchingInformation,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SplashCheckLoginState) {
        if (state.isLoggedIn) {
          context.read<SplashBloc>().add(const GetMessageEvent());
        } else {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      } else if (state is SplashLoadedState || state is SplashErrorState) {
        Navigator.pushReplacementNamed(context, Routes.chat);
      }
    });
  }
}
