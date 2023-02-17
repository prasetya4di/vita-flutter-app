import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_image.g.dart';

@JsonSerializable()
class UploadImage {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? image;
  String email;

  UploadImage(this.email);

  factory UploadImage.fromJson(Map<String, dynamic> json) =>
      _$UploadImageFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageToJson(this);
}
