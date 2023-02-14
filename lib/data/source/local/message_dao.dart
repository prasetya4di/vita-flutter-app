import 'package:hive/hive.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/entity/messages.dart';

class MessageDao {
  Box box;

  MessageDao(this.box);

  inserts(List<Message> messages) async {
    Messages listMessage = Messages(messages);
    box.put("messages", listMessage);
  }

  Future<List<Message>> get() async {
    List<Message> messages = box.values.toList().cast();
    return messages;
  }
}
