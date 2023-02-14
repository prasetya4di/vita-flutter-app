import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/generated/assets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vita',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            titleSmall:
                TextStyle(fontFamily: Assets.fontsPoppinsBold, fontSize: 12),
            bodySmall:
                TextStyle(fontFamily: Assets.fontsPoppinsRegular, fontSize: 12),
            bodyMedium:
                TextStyle(fontFamily: Assets.fontsPoppinsRegular, fontSize: 14),
            bodyLarge:
                TextStyle(fontFamily: Assets.fontsPoppinsRegular, fontSize: 18),
            labelSmall: TextStyle(
                fontFamily: Assets.fontsPoppinsSemiBold, fontSize: 12),
            labelMedium: TextStyle(
                fontFamily: Assets.fontsPoppinsSemiBold, fontSize: 14),
            labelLarge: TextStyle(
                fontFamily: Assets.fontsPoppinsSemiBold, fontSize: 18),
          )),
    );
  }
}
