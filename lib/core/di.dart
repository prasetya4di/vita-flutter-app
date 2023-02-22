import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/source/local/image_dao.dart';
import 'package:vita_client_app/data/source/local/impl/image_dao_impl.dart';
import 'package:vita_client_app/data/source/local/impl/message_dao_impl.dart';
import 'package:vita_client_app/data/source/local/impl/user_dao_impl.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';
import 'package:vita_client_app/data/source/local/objectbox.dart';
import 'package:vita_client_app/data/source/local/user_dao.dart';
import 'package:vita_client_app/data/source/network/chopper_service.dart';
import 'package:vita_client_app/data/source/network/image_service.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';
import 'package:vita_client_app/data/source/network/user_service.dart';
import 'package:vita_client_app/domain/check_login.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/domain/get_token.dart';
import 'package:vita_client_app/domain/get_user.dart';
import 'package:vita_client_app/domain/impl/check_login_impl.dart';
import 'package:vita_client_app/domain/impl/fetch_message_impl.dart';
import 'package:vita_client_app/domain/impl/get_token_impl.dart';
import 'package:vita_client_app/domain/impl/get_user_impl.dart';
import 'package:vita_client_app/domain/impl/load_message_impl.dart';
import 'package:vita_client_app/domain/impl/load_possibility_impl.dart';
import 'package:vita_client_app/domain/impl/pick_image_impl.dart';
import 'package:vita_client_app/domain/impl/post_login_impl.dart';
import 'package:vita_client_app/domain/impl/post_register_impl.dart';
import 'package:vita_client_app/domain/impl/reply_message_impl.dart';
import 'package:vita_client_app/domain/impl/scan_image_impl.dart';
import 'package:vita_client_app/domain/impl/send_message_impl.dart';
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/domain/load_possibility.dart';
import 'package:vita_client_app/domain/pick_image.dart';
import 'package:vita_client_app/domain/post_login.dart';
import 'package:vita_client_app/domain/post_register.dart';
import 'package:vita_client_app/domain/reply_message.dart';
import 'package:vita_client_app/domain/scan_image.dart';
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/impl/image_repository_impl.dart';
import 'package:vita_client_app/repository/impl/message_repository_impl.dart';
import 'package:vita_client_app/repository/impl/user_repository_impl.dart';
import 'package:vita_client_app/repository/message_repository.dart';
import 'package:vita_client_app/repository/user_repository.dart';

final di = GetIt.I;

Future<void> setupDI() async {
  // dao
  final objectBox = await ObjectBox.create();
  final imagePicker = ImagePicker();
  di.registerSingleton<Box<User>>(objectBox.store.box<User>());
  di.registerSingleton<Box<Message>>(objectBox.store.box<Message>());
  di.registerSingleton<Box<ImagePossibility>>(
      objectBox.store.box<ImagePossibility>());
  di.registerSingleton<MessageDao>(MessageDaoImpl(di.get()));
  di.registerSingleton<ImageDao>(ImageDaoImpl(imagePicker, di.get()));
  di.registerSingleton<UserDao>(UserDaoImpl(di.get()));

  // service
  di.registerSingleton<MessageService>(
      chopperClient.getService<MessageService>());
  di.registerSingleton<ImageService>(chopperClient.getService<ImageService>());
  di.registerSingleton<UserService>(chopperClient.getService<UserService>());

  // repository
  di.registerSingleton<MessageRepository>(
      MessageRepositoryImpl(di.get(), di.get()));
  di.registerSingleton<ImageRepository>(
      ImageRepositoryImpl(di.get(), di.get()));
  di.registerSingleton<UserRepository>(UserRepositoryImpl(di.get(), di.get()));

  // use case
  di.registerSingleton<FetchMessage>(FetchMessageImpl(di.get()));
  di.registerSingleton<LoadMessage>(LoadMessageImpl(di.get()));
  di.registerSingleton<SendMessage>(SendMessageImpl(di.get()));
  di.registerSingleton<PickImage>(PickImageImpl(di.get()));
  di.registerSingleton<ScanImage>(ScanImageImpl(di.get(), di.get()));
  di.registerSingleton<LoadPossibility>(LoadPossibilityImpl(di.get()));
  di.registerSingleton<ReplyMessage>(ReplyMessageImpl(di.get(), di.get()));
  di.registerSingleton<CheckLogin>(CheckLoginImpl(di.get()));
  di.registerSingleton<GetUser>(GetUserImpl(di.get()));
  di.registerSingleton<PostLogin>(PostLoginImpl(di.get()));
  di.registerSingleton<PostRegister>(PostRegisterImpl(di.get(), di.get()));
  di.registerSingleton<GetToken>(GetTokenImpl(di.get()));
}
