import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/data/model/response/login_response.dart';
import 'package:vita_client_app/data/model/response/register_response.dart';

part 'user_service.chopper.dart';

@ChopperApi()
abstract class UserService extends ChopperService {
  static UserService create([ChopperClient? client]) => _$UserService(client);

  @Post(path: "/login")
  Future<Response<LoginResponse>> login(@Body() LoginRequest request);

  @Post(path: "/register")
  Future<Response<RegisterResponse>> register(@Body() RegisterRequest request);
}
