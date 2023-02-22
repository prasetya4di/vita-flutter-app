import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/data/model/response/login_response.dart';
import 'package:vita_client_app/data/model/response/register_response.dart';

abstract class UserRepository {
  insert(User user);

  User read();

  String getToken();

  bool isLoggedIn();

  Future<Response<LoginResponse>> login(LoginRequest request);

  Future<Response<RegisterResponse>> register(RegisterRequest request);
}
