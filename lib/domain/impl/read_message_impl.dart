import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/domain/read_message.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class ReadMessageImpl implements ReadMessage {
  final MessageRepository _repository;

  ReadMessageImpl(this._repository);

  @override
  Future<List<Message>> call() {
    return _repository.read();
  }
}
