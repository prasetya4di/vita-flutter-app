import 'package:json_annotation/json_annotation.dart';
import 'package:vita_client_app/data/model/entity/user.dart';

@JsonSerializable()
class RegisterResponse {
  User user;
  RegisterResponse message;

  RegisterResponse(this.user, this.message);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
