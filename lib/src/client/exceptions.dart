import 'package:http/http.dart' as http;

/// Thrown when the client receives a response with the
/// Content-Type different from [Document.mediaType]
class InvalidContentTypeException implements Exception {
  InvalidContentTypeException(this.response);

  final http.Response response;
}
