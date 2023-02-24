import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart'
    as request;
import 'package:vita_client_app/data/model/response/response_error.dart';

abstract class SendMessage {
  Future<Either<ResponseError, List<Message>>> call(
      request.SendMessage message);
}
