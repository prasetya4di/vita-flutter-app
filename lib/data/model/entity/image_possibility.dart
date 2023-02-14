import 'package:json_annotation/json_annotation.dart';

part 'image_possibility.g.dart';

@JsonSerializable()
class ImagePossibility {
  String type;
  String description;

  ImagePossibility(this.type, this.description);

  factory ImagePossibility.fromJson(Map<String, dynamic> json) =>
      _$ImagePossibilityFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePossibilityToJson(this);
}
