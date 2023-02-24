import 'package:either_dart/either.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/request/register_request.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';

abstract class PostRegister {
  Future<Either<ResponseError, User>> call(RegisterRequest request);
}
