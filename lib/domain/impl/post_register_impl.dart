import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/data/model/response/register_response.dart';
import 'package:vita_client_app/domain/post_register.dart';
import 'package:vita_client_app/repository/message_repository.dart';
import 'package:vita_client_app/repository/user_repository.dart';

class PostRegisterImpl implements PostRegister {
  final UserRepository _userRepository;
  final MessageRepository _messageRepository;

  PostRegisterImpl(this._userRepository, this._messageRepository);

  @override
  Future<User> call(RegisterRequest request) async {
    var response = await _userRepository.register(request);
    RegisterResponse data = response.body!;
    await _userRepository.clear();
    await _messageRepository.deleteMessage();
    _userRepository.insert(data.user);
    _messageRepository.inserts([data.message]);
    return data.user;
  }
}
