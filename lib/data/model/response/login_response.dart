import 'package:json_annotation/json_annotation.dart';
import 'package:vita_client_app/data/model/entity/user.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  User user;

  LoginResponse(this.user);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
