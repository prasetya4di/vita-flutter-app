import 'package:vita_client_app/domain/logout.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/message_repository.dart';
import 'package:vita_client_app/repository/user_repository.dart';

class LogoutImpl implements Logout {
  final UserRepository _userRepository;
  final MessageRepository _messageRepository;
  final ImageRepository _imageRepository;

  LogoutImpl(
      this._userRepository, this._messageRepository, this._imageRepository);

  @override
  void call() {
    _userRepository.clear();
    _messageRepository.clear();
    _imageRepository.clear();
  }
}
