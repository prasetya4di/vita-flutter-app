import 'package:dartz/dartz.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart'
    as request;
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/domain/reply_message.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class ReplyMessageImpl implements ReplyMessage {
  final MessageRepository _messageRepository;
  final ImageRepository _imageRepository;

  ReplyMessageImpl(this._messageRepository, this._imageRepository);

  @override
  Future<Either<ResponseError, List<Message>>> call(
      request.ReplyMessage message) async {
    var response = await _messageRepository.replyMessage(message);
    if (response.body != null) {
      var messages = response.body!;
      _messageRepository.inserts(messages);
      _imageRepository.clear();
      return Right(messages);
    } else {
      return Left(response.error as ResponseError);
    }
  }
}
