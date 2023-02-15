import 'package:json_annotation/json_annotation.dart';

part 'response_error.g.dart';

@JsonSerializable()
class ResponseError {
  final String message;

  ResponseError(this.message);

  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);

  factory ResponseError.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorFromJson(json);

  static const fromJsonFactory = _$ResponseErrorFromJson;
}
