import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int id;
  String email;
  String message;
  @JsonKey(name: "created_date")
  DateTime createdDate;
  @JsonKey(name: "message_type")
  String messageType;
  @JsonKey(name: "file_type")
  String fileType;

  Message(this.id, this.email, this.message, this.createdDate, this.messageType,
      this.fileType);

  Message.name(this.id, this.email, this.message, this.createdDate,
      this.messageType, this.fileType);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
