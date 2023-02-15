import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/source/local/impl/message_dao_impl.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';
import 'package:vita_client_app/data/source/local/objectbox.dart';
import 'package:vita_client_app/data/source/network/chopper_service.dart';
import 'package:vita_client_app/data/source/network/image_service.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/domain/impl/fetch_message_impl.dart';
import 'package:vita_client_app/domain/impl/load_message_impl.dart';
import 'package:vita_client_app/domain/impl/send_message_impl.dart';
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/repository/impl/message_repository_impl.dart';
import 'package:vita_client_app/repository/message_repository.dart';

final di = GetIt.I;

Future<void> setupDI() async {
  // dao
  final objectBox = await ObjectBox.create();
  di.registerSingleton<Box<Message>>(objectBox.store.box<Message>());
  di.registerSingleton<MessageDao>(MessageDaoImpl(di.get()));

  // service
  di.registerSingleton<MessageService>(
      chopperClient.getService<MessageService>());
  di.registerSingleton<ImageService>(chopperClient.getService<ImageService>());

  // repository
  di.registerSingleton<MessageRepository>(
      MessageRepositoryImpl(di.get(), di.get()));

  // use case
  di.registerSingleton<FetchMessage>(FetchMessageImpl(di.get()));
  di.registerSingleton<LoadMessage>(LoadMessageImpl(di.get()));
  di.registerSingleton<SendMessage>(SendMessageImpl(di.get()));
}
