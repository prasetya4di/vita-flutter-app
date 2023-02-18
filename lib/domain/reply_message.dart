import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart';

abstract class ReplyMessage {
  Future<Either<Error, List<Message>>> call(SendMessage message);
}
