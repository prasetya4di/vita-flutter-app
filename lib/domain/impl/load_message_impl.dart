import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class LoadMessageImpl implements LoadMessage {
  final MessageRepository _repository;

  LoadMessageImpl(this._repository);

  @override
  Future<List<Message>> call() {
    return _repository.read();
  }
}
