import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';

Message createMessage() => Message(
    randomBetween(0, 100),
    randomString(5),
    randomString(5),
    DateTime(2000, randomBetween(1, 12), randomBetween(1, 30)),
    randomString(5),
    randomString(5));

List<Message> createListMessage() =>
    [createMessage(), createMessage(), createMessage()];

User createUser() => User(
    randomString(5),
    randomString(5),
    randomString(5),
    randomString(5),
    DateTime(2000, randomBetween(1, 12), randomBetween(1, 30)),
    randomString(5));

ImagePossibility createImagePossiblity() =>
    ImagePossibility(randomString(5), randomString(5));

LoginRequest createLoginRequest() =>
    LoginRequest(randomString(5), randomString(5));

RegisterRequest createRegisterRequest() => RegisterRequest(
      randomString(5),
      randomString(5),
      randomString(5),
      randomString(5),
      randomString(5),
      DateTime(2000, randomBetween(1, 12), randomBetween(1, 30)),
    );
