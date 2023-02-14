import 'package:chopper/src/response.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart';
import 'package:vita_client_app/data/source/local/message_dao.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class MessageRepositoryImpl extends MessageRepository {
  final MessageDao _messageDao;
  final MessageService _messageService;

  MessageRepositoryImpl(this._messageDao, this._messageService);

  @override
  Future<List<Message>> read() {
    return _messageDao.get();
  }

  @override
  Future<Response<List<Message>>> getMessage() {
    return _messageService.getMessage();
  }

  @override
  inserts(List<Message> messages) {
    _messageDao.inserts(messages);
  }

  @override
  Future<Response<List<Message>>> replyMessage(SendMessage request) {
    return _messageService.replyMessage(request);
  }

  @override
  Future<Response<List<Message>>> sendMessage(SendMessage request) {
    return _messageService.sendMessage(request);
  }
}
