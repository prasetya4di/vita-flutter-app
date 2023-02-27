import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';

abstract class PostLogin {
  Future<User> call(LoginRequest request);
}
