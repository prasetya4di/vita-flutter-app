import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/message.dart';

abstract class FetchMessage {
  Future<Either<Error, List<Message>>> call();
}
