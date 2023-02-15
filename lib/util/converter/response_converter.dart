import 'package:chopper/chopper.dart';
import 'package:vita_client_app/data/model/response/response_error.dart';

import 'json_type_parser.dart';

class ResponseConverter extends JsonConverter {
  @override
  Response<ResultType> convertResponse<ResultType, Item>(Response response) {
    final jsonRes = super.convertResponse<dynamic, dynamic>(response);
    if (jsonRes.body == null ||
        (jsonRes.body is String && (jsonRes.body as String).isEmpty)) {
      return jsonRes.copyWith(body: null);
    }
    final dynamic body = jsonRes.body["data"]!;
    final dynamic decodedItem = JsonTypeParser.decode<Item>(body);
    return jsonRes.copyWith<ResultType>(body: decodedItem as ResultType);
  }

  @override
  Response convertError<BodyType, InnerType>(Response response) {
    final jsonRes = super.convertError<BodyType, InnerType>(response);
    final dynamic body = jsonRes.body;
    final dynamic responseError = JsonTypeParser.decode<ResponseError>(body);
    return jsonRes.copyWith<BodyType>(bodyError: responseError as BodyType);
  }
}
