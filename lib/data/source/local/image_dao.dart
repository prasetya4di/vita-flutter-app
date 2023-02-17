import 'package:image_picker/image_picker.dart';

abstract class ImageDao {
  Future<XFile?> pickImage(ImageSource source);
}
