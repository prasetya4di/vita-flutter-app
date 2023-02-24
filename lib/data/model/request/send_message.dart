import 'package:json_annotation/json_annotation.dart';

part 'send_message.g.dart';

@JsonSerializable()
class SendMessage {
  String email;
  String message;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isError = false;

  SendMessage(this.email, this.message);

  factory SendMessage.fromJson(Map<String, dynamic> json) =>
      _$SendMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageToJson(this);
}
