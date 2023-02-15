import 'package:vita_client_app/data/model/entity/message.dart';

abstract class LoadMessage {
  Future<List<Message>> call();
}
