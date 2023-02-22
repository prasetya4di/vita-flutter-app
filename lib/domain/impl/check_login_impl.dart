import 'package:vita_client_app/domain/check_login.dart';
import 'package:vita_client_app/repository/user_repository.dart';

class CheckLoginImpl implements CheckLogin {
  final UserRepository _repository;

  CheckLoginImpl(this._repository);

  @override
  bool call() {
    return _repository.isLoggedIn();
  }
}
