import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/source/local/impl/message_dao_impl.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';
import 'package:vita_client_app/generated/assets.dart';
import 'package:vita_client_app/repository/impl/message_repository_impl.dart';
import 'package:vita_client_app/repository/message_repository.dart';

import 'data/source/local/objectbox.dart';
import 'data/source/network/chopper_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ObjectBox objectbox = await ObjectBox.create();
  MessageDao messageDao = MessageDaoImpl(objectbox.store.box<Message>());
  MessageRepository messageRepository = MessageRepositoryImpl(
      messageDao, chopperClient.getService<MessageService>());
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
