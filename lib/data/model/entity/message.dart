import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vita_client_app/util/converter/date_time_converter.dart';

part 'message.g.dart';

@JsonSerializable()
@Entity()
class Message extends Equatable {
  @Id()
  @JsonKey(includeToJson: false, includeFromJson: false)
  int obxId = 0;
  int id;
  String email;
  String message;
  @DatetimeJsonConverter()
  @Property(type: PropertyType.date)
  @JsonKey(name: "created_date")
  DateTime createdDate;
  @JsonKey(name: "message_type")
  String messageType;
  @JsonKey(name: "file_type")
  String fileType;

  Message(this.id, this.email, this.message, this.createdDate, this.messageType,
      this.fileType);

  Message.name(this.obxId, this.id, this.email, this.message, this.createdDate,
      this.messageType, this.fileType);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  List<Object?> get props =>
      [id, email, message, createdDate, messageType, fileType];
}
