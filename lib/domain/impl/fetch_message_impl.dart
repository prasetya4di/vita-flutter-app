import 'dart:async';

import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class FetchMessageImpl implements FetchMessage {
  final MessageRepository _repository;

  FetchMessageImpl(this._repository);

  @override
  Future<void> call() async {
    var response = await _repository.getMessage();
    if (response.isSuccessful) {
      if (response.body != null) {
        await _repository.deleteMessage();
        _repository.inserts(response.body!);
      }
    }
  }
}
