import 'package:json_annotation/json_annotation.dart';

part 'reply_message.g.dart';

@JsonSerializable()
class ReplyMessage {
  String message;

  ReplyMessage(this.message);

  factory ReplyMessage.fromJson(Map<String, dynamic> json) =>
      _$ReplyMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyMessageToJson(this);
}
