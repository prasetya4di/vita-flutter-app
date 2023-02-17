import 'package:chopper/chopper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';

abstract class ImageRepository {
  Future<XFile?> pickImage(ImageSource source);

  Future<Response<List<ImagePossibility>>> scanImage(XFile image);
}
