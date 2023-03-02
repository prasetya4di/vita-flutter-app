import 'dart:async';

import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class FetchMessageImpl implements FetchMessage {
  final MessageRepository _repository;

  FetchMessageImpl(this._repository);

  @override
  Future<List<Message>> call() async {
    var response = await _repository.getMessage();
    if (response.body != null) {
      var messages = response.body!;
      _repository.clear();
      _repository.inserts(messages);
      return messages;
    } else {
      return [];
    }
  }
}
