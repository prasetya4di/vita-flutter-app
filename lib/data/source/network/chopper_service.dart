import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/source/network/image_service.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';
import 'package:vita_client_app/util/converter/response_converter.dart';

final chopperClient = ChopperClient(
  baseUrl: Uri(scheme: "http", host: "127.0.0.1", port: 8080),
  converter: ResponseConverter(),
  errorConverter: ResponseConverter(),
  services: [MessageService.create(), ImageService.create()],
);
