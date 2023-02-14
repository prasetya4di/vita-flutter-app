import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart'
    as request;
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class SendMessageImpl implements SendMessage {
  final MessageRepository _repository;

  SendMessageImpl(this._repository);

  @override
  Future<Either<Error, List<Message>>> call(request.SendMessage message) async {
    var response = await _repository.sendMessage(message);
    if (response.isSuccessful && response.body != null) {
      var messages = response.body!;
      _repository.inserts(messages);
      return Right(messages);
    } else {
      return Left(response.error! as Error);
    }
  }
}
