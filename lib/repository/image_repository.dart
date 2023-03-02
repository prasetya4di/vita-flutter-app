import 'package:chopper/chopper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';

abstract class ImageRepository {
  Future<XFile?> pickImage(ImageSource source);

  Future<Response<ScannedImage>> scanImage(XFile image);

  inserts(List<ImagePossibility> possibilities);

  Future<List<ImagePossibility>> read();

  clear();
}
