import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart'
    as request;

abstract class SendMessage {
  Future<List<Message>> call(request.SendMessage message);
}
