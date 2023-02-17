import 'package:image_picker/image_picker.dart';

abstract class PickImage {
  Future<XFile?> call(ImageSource source);
}
