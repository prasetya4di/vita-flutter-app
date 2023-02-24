import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/fetch_message.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class FetchMessageImpl implements FetchMessage {
  final MessageRepository _repository;

  FetchMessageImpl(this._repository);

  @override
  Future<Either<ResponseError, List<Message>>> call() async {
    var response = await _repository.getMessage();
    if (response.isSuccessful && response.body != null) {
      var messages = response.body!;
      await _repository.deleteMessage();
      _repository.inserts(messages);
      return Right(messages);
    } else {
      return Left(response.error as ResponseError);
    }
  }
}
