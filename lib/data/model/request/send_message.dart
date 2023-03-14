import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_message.g.dart';

@JsonSerializable()
class SendMessage extends Equatable {
  String message;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isError = false;

  SendMessage(this.message);

  factory SendMessage.fromJson(Map<String, dynamic> json) =>
      _$SendMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageToJson(this);

  @override
  List<Object?> get props => [message, isError];
}
