import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/util/constant/dummy.dart';

part 'image_service.chopper.dart';

@ChopperApi(baseUrl: "/image")
abstract class ImageService extends ChopperService {
  static ImageService create([ChopperClient? client]) => _$ImageService(client);

  @Post(path: "/${Dummy.email}")
  Future<Response<List<ImagePossibility>>> scanImage(@PartFile() image);
}
