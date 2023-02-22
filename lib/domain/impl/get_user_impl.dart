import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/domain/get_user.dart';
import 'package:vita_client_app/repository/user_repository.dart';

class GetUserImpl implements GetUser {
  final UserRepository _repository;

  GetUserImpl(this._repository);

  @override
  User call() {
    return _repository.read();
  }
}
