import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/source/network/image_service.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';

final chopperClient = ChopperClient(
    baseUrl: Uri(host: "localhost", port: 8080),
    services: [MessageService.create(), ImageService.create()]);
