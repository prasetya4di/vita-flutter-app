import 'package:chopper/chopper.dart';
import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/login_request.dart';

abstract class PostLogin {
  Future<Either<Response, User>> call(LoginRequest request);
}
