import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/entity/user.dart';
import 'package:vita_client_app/data/model/response/login_response.dart';
import 'package:vita_client_app/data/model/response/register_response.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';
import 'package:vita_client_app/data/model/response/scanned_image.dart';
import 'package:vita_client_app/util/converter/parser_exception.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class JsonTypeParser {
  static const Map<Type, JsonFactory> factories = {
    Message: Message.fromJson,
    User: User.fromJson,
    ImagePossibility: ImagePossibility.fromJson,
    ScannedImage: ScannedImage.fromJson,
    LoginResponse: LoginResponse.fromJson,
    RegisterResponse: RegisterResponse.fromJson,
    ResponseError: ResponseError.fromJson
  };

  static dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) return _decodeList<T>(entity);

    if (entity is Map<String, dynamic>) return _decodeMap<T>(entity);

    return entity;
  }

  static T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      /// throw serializer not found error;
      throw JsonFactoryNotFoundException(T.toString());
    }

    return jsonFactory(values);
  }

  static List<T> _decodeList<T>(Iterable values) => values
      .where((dynamic v) => v != null)
      .map((dynamic v) => decode<T>(v) as T)
      .toList();
}
