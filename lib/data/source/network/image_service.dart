import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';
import 'package:vita_client_app/util/constant/dummy.dart';

part 'image_service.chopper.dart';

@ChopperApi(baseUrl: "/image")
abstract class ImageService extends ChopperService {
  static ImageService create([ChopperClient? client]) => _$ImageService(client);

  @Post(path: "/${Dummy.email}")
  @multipart
  Future<Response<ScannedImage>> scanImage(@PartFile('image') String image);
}
