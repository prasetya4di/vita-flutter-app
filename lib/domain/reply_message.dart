import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart'
    as request;
import 'package:vita_client_app/data/model/response/response_error.dart';

abstract class ReplyMessage {
  Future<Either<ResponseError, List<Message>>> call(
      request.ReplyMessage message);
}
