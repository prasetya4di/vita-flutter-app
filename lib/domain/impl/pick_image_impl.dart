import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/domain/pick_image.dart';
import 'package:vita_client_app/repository/image_repository.dart';

class PickImageImpl implements PickImage {
  final ImageRepository _repository;

  PickImageImpl(this._repository);

  @override
  Future<XFile?> call(ImageSource source) {
    return _repository.pickImage(source);
  }
}
