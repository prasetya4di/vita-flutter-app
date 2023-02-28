import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart'
    as request;
import 'package:vita_client_app/domain/reply_message.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class ReplyMessageImpl implements ReplyMessage {
  final MessageRepository _messageRepository;
  final ImageRepository _imageRepository;

  ReplyMessageImpl(this._messageRepository, this._imageRepository);

  @override
  Future<List<Message>> call(request.ReplyMessage message) async {
    var response = await _messageRepository.replyMessage(message);
    var messages = response.body!;
    _messageRepository.inserts(messages);
    _imageRepository.clear();
    return messages;
  }
}
