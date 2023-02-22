import 'package:vita_client_app/domain/get_token.dart';
import 'package:vita_client_app/repository/user_repository.dart';

class GetTokenImpl implements GetToken {
  final UserRepository _repository;

  GetTokenImpl(this._repository);

  @override
  String call() {
    return _repository.getToken();
  }
}
