import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';

abstract class ImageDao {
  Future<XFile?> pickImage(ImageSource source);

  inserts(List<ImagePossibility> possibilities);

  Future<List<ImagePossibility>> get();

  delete();
}
