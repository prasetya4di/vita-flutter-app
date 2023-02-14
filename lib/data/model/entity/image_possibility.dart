import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_possibility.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class ImagePossibility extends HiveObject {
  @HiveField(0)
  String type;
  @HiveField(1)
  String description;

  ImagePossibility(this.type, this.description);

  factory ImagePossibility.fromJson(Map<String, dynamic> json) =>
      _$ImagePossibilityFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePossibilityToJson(this);
}
