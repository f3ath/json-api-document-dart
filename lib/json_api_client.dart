
import 'package:http/http.dart' as http;
import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/src/client/exceptions.dart';
import 'package:json_api_document/src/client/fetch_result.dart';

export 'package:json_api_document/src/client/exceptions.dart';
export 'package:json_api_document/src/client/fetch_result.dart';

/// JSON:API client
///
/// The client is based on top of Dart's [http.Client] class. To use a custom
/// client, provide your own [clientFactory].
class JsonApiClient {
  JsonApiClient({
    this.baseUrl = '',
    ClientFactory clientFactory,
    Map<String, String> defaultHeaders = const {},
  })  : clientFactory = clientFactory ?? (() => http.Client()),
        defaultHeaders = Map.unmodifiable({}
          ..addAll(defaultHeaders)
          ..['Accept'] = Document.mediaType);

  final String baseUrl;
  final ClientFactory clientFactory;
  final Map<String, String> defaultHeaders;

  /// Fetches a [Document] from the given [url].
  /// Pass a [Map] of [headers] to add extra headers to the request.
  Future<FetchResult> fetch(String url,
      {Map<String, String> headers = const {}}) async {
    final response = await _exec(
        (_) => _.get('${baseUrl}${url}', headers: _makeHeaders(headers)));
    _enforceContentType(response);
    return FetchResult(response);
  }

  void _enforceContentType(http.Response response) {
    const contentType = 'content-type';
    if (response.headers.containsKey(contentType) &&
        response.headers[contentType].startsWith(Document.mediaType)) return;

    throw InvalidContentTypeException(response);
  }

  Map<String, String> _makeHeaders(Map<String, String> headers) =>
      {}..addAll(defaultHeaders)..addAll(headers);

  Future<http.Response> _exec(
      Future<http.Response> fn(http.Client client)) async {
    final client = clientFactory();
    try {
      return await fn(client);
    } finally {
      client.close();
    }
  }

  create(String url, Resource resource, {Map<String, String> headers}) {}
}

typedef http.Client ClientFactory();
//
//
//abstract class AuthorizationHeader {
//  final key = 'Authorization';
//
//  String get value;
//
//  Map<String, String> get asMap => {key: value};
//}
//
//class AuthorizationHeaderBasic extends AuthorizationHeader {
//  AuthorizationHeaderBasic(String username, String password)
//      : value = base64.encode(utf8.encode('Basic ${username}:${password}'));
//
//  final String value;
//}
//
//class AuthorizationHeaderBearer extends AuthorizationHeader {
//  AuthorizationHeaderBearer(String token) : value = 'Bearer ${token}';
//
//  final String value;
//}
