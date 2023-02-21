import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/source/network/image_service.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';
import 'package:vita_client_app/data/source/network/user_service.dart';
import 'package:vita_client_app/util/constant/endpoint.dart';
import 'package:vita_client_app/util/converter/response_converter.dart';

final chopperClient = ChopperClient(
  baseUrl: Uri.parse(baseUrl),
  converter: ResponseConverter(),
  errorConverter: ResponseConverter(),
  services: [
    MessageService.create(),
    ImageService.create(),
    UserService.create()
  ],
);
