import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String message;
  @JsonKey(name: "created_date")
  @HiveField(3)
  DateTime createdDate;
  @JsonKey(name: "message_type")
  @HiveField(4)
  String messageType;
  @JsonKey(name: "file_type")
  @HiveField(5)
  String fileType;

  Message(this.id, this.email, this.message, this.createdDate, this.messageType,
      this.fileType);

  Message.name(this.id, this.email, this.message, this.createdDate,
      this.messageType, this.fileType);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
