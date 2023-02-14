import 'package:vita_client_app/data/model/entity/message.dart';

abstract class ReadMessage {
  Future<List<Message>> call();
}
