import 'package:json_annotation/json_annotation.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/entity/user.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  User user;
  Message message;

  RegisterResponse(this.user, this.message);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
