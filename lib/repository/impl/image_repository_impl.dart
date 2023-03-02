import 'package:chopper/chopper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';
import 'package:vita_client_app/data/source/local/image_dao.dart';
import 'package:vita_client_app/data/source/network/image_service.dart';
import 'package:vita_client_app/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDao dao;
  final ImageService service;

  ImageRepositoryImpl(this.dao, this.service);

  @override
  Future<XFile?> pickImage(ImageSource source) {
    return dao.pickImage(source);
  }

  @override
  Future<Response<ScannedImage>> scanImage(XFile image) {
    return service.scanImage(image.path);
  }

  @override
  clear() async {
    dao.delete();
  }

  @override
  inserts(List<ImagePossibility> possibilities) {
    dao.inserts(possibilities);
  }

  @override
  Future<List<ImagePossibility>> read() {
    return dao.get();
  }
}
