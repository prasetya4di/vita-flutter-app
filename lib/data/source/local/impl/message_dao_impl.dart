import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';

class MessageDaoImpl implements MessageDao {

  @override
  inserts(List<Message> messages) async {}

  @override
  Future<List<Message>> get() async {
    return [];
  }
}
