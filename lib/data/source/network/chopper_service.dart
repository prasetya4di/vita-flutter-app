import 'package:chopper/chopper.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/data/source/local/user_dao.dart';
import 'package:vita_client_app/data/source/network/image_service.dart';
import 'package:vita_client_app/data/source/network/message_service.dart';
import 'package:vita_client_app/data/source/network/user_service.dart';
import 'package:vita_client_app/util/constant/endpoint.dart';
import 'package:vita_client_app/util/converter/response_converter.dart';

ChopperClient chopperClient() => ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      converter: ResponseConverter(),
      errorConverter: ResponseConverter(),
      interceptors: [
        (Request request) async {
          var token = di.get<UserDao>().getToken();
          if (token.isNotEmpty) {
            return applyHeader(request, 'Authorization', 'Bearer $token');
          }
          return request;
        }
      ],
      services: [
        MessageService.create(),
        ImageService.create(),
        UserService.create()
      ],
    );
