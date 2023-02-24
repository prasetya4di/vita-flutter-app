import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';

abstract class FetchMessage {
  Future<Either<ResponseError, List<Message>>> call();
}
