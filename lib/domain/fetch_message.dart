import 'dart:async';

import 'package:vita_client_app/data/model/entity/message.dart';

abstract class FetchMessage {
  Future<List<Message>> call();
}
