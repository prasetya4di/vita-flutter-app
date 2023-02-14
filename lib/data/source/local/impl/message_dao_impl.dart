import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';
import 'package:vita_client_app/objectbox.g.dart';

class MessageDaoImpl implements MessageDao {
  Box<Message> _boxMessage;

  MessageDaoImpl(this._boxMessage);

  @override
  inserts(List<Message> messages) async {
    _boxMessage.putMany(messages);
  }

  @override
  Future<List<Message>> get() async {
    return _boxMessage.getAll();
  }
}
