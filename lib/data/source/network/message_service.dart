import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart';
import 'package:vita_client_app/util/constant/dummy.dart';

part 'message_service.chopper.dart';

@ChopperApi(baseUrl: "/message")
abstract class MessageService extends ChopperService {
  static MessageService create([ChopperClient? client]) =>
      _$MessageService(client);

  @Get(path: "/${Dummy.email}")
  Future<Response<List<Message>>> getMessage();

  @Post()
  Future<Response<List<Message>>> sendMessage(@Body() SendMessage request);
}
