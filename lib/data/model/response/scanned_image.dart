import 'package:json_annotation/json_annotation.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/entity/message.dart';

part 'scanned_image.g.dart';

@JsonSerializable()
class ScannedImage {
  List<Message> messages;
  List<ImagePossibility> possibilities;

  ScannedImage(this.messages, this.possibilities);

  factory ScannedImage.fromJson(Map<String, dynamic> json) =>
      _$ScannedImageFromJson(json);

  Map<String, dynamic> toJson() => _$ScannedImageToJson(this);
}
