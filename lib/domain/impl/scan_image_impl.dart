import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';
import 'package:vita_client_app/domain/scan_image.dart';
import 'package:vita_client_app/repository/image_repository.dart';
import 'package:vita_client_app/repository/message_repository.dart';

class ScanImageImpl implements ScanImage {
  final ImageRepository _repository;
  final MessageRepository _messageRepository;

  ScanImageImpl(this._repository, this._messageRepository);

  @override
  Future<ScannedImage> call(XFile image) async {
    var response = await _repository.scanImage(image);
    var result = response.body!;
    await _repository.clear();
    _messageRepository.inserts(result.messages);
    _repository.inserts(result.possibilities);
    return result;
  }
}
