import 'package:hive/hive.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/entity/messages.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';

class MessageDaoImpl implements MessageDao {
  Box box;

  MessageDaoImpl(this.box);

  @override
  inserts(List<Message> messages) async {
    Messages listMessage = Messages(messages);
    box.put("messages", listMessage);
  }

  @override
  Future<List<Message>> get() async {
    List<Message> messages = box.get("messages");
    return messages;
  }
}
