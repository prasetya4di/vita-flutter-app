import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';

Message createMessage() => Message(
    randomBetween(0, 100),
    randomString(5),
    randomString(5),
    DateTime(2000, randomBetween(1, 12), randomBetween(1, 30)),
    randomString(5),
    randomString(5));

List<Message> createListMessage() =>
    [createMessage(), createMessage(), createMessage()];

SendMessage createSendMessageRequest() => SendMessage(randomString(5));

ReplyMessage createReplyMessageRequest() => ReplyMessage(randomString(5));

User createUser() => User(
    randomBetween(0, 100),
    randomString(5),
    randomString(5),
    randomString(5),
    randomString(5),
    DateTime(2000, randomBetween(1, 12), randomBetween(1, 30)),
    randomString(5));

ImagePossibility createImagePossiblity() =>
    ImagePossibility(randomString(5), randomString(5));

List<ImagePossibility> createPossibilities() =>
    [createImagePossiblity(), createImagePossiblity(), createImagePossiblity()];

ScannedImage createScannedImageResponse() =>
    ScannedImage(createListMessage(), createPossibilities());

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

XFile createXFile() => XFile(randomString(5), name: randomString(5));

ImageSource createImageSource() => ImageSource.values[randomBetween(0, 1)];

ResponseError createResponseError() => ResponseError(randomString(5));
