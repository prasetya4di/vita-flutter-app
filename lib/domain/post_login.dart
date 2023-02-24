import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';

abstract class PostLogin {
  Future<Either<ResponseError, User>> call(LoginRequest request);
}
