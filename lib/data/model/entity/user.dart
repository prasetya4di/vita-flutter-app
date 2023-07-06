import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.g.dart';

@JsonSerializable()
@Entity()
class User extends Equatable {
  @Id()
  @JsonKey(includeToJson: false, includeFromJson: false)
  int obxId = 0;
  String email;
  @JsonKey(name: "first_name")
  String firstName;
  @JsonKey(name: "last_name")
  String lastName;
  String nickname;
  @JsonKey(name: "birth_date")
  @Property(type: PropertyType.date)
  DateTime birthDate;
  String token;

  User(this.email, this.firstName, this.lastName, this.nickname,
      this.birthDate, this.token);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props =>
      [email, firstName, lastName, nickname, birthDate, token];
}
