import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  String email;
  String password;
  @JsonKey(name: "first_name")
  String firstName;
  @JsonKey(name: "last_name")
  String lastName;
  String nickname;
  @JsonKey(name: "birth_date")
  DateTime birthDate;

  RegisterRequest(this.email, this.password, this.firstName, this.lastName,
      this.nickname, this.birthDate);

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
