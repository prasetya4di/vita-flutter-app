import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';

abstract class PostRegister {
  Future<User> call(RegisterRequest request);
}
