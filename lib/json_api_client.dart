import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/src/client/exceptions.dart';
import 'package:json_api_document/src/client/response.dart';

export 'package:json_api_document/src/client/exceptions.dart';
export 'package:json_api_document/src/client/response.dart';

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
  final api = Api('1.0');

  /// Fetches a [Document] containing resource(s) from the given [url].
  /// Pass a [Map] of [headers] to add extra headers to the request.
  ///
  /// https://jsonapi.org/format/#fetching-resources
  Future<Response> fetch(String url,
      {Map<String, String> headers = const {}}) async {
    final response = await _exec(
        (_) => _.get(_makeUrl(url), headers: _makeHeaders(headers)));
    return Response.fromHttp(response, preferResource: true);
  }

  /// Fetches a [Document] containing identifier(s) from the given [url].
  /// Pass a [Map] of [headers] to add extra headers to the request.
  ///
  /// https://jsonapi.org/format/#fetching-relationships
  fetchRelationship(String url,
      {Map<String, String> headers = const {}}) async {
    final response = await _exec(
        (_) => _.get(_makeUrl(url), headers: _makeHeaders(headers)));
    return Response.fromHttp(response);
  }

  /// Creates a new [resource] sending a POST request to the [url].
  createResource(String url, Resource resource,
      {Map<String, String> headers = const {}}) async {
    final document = DataDocument.fromResource(resource, api: api);
    final response = await _exec((_) => _.post(_makeUrl(url),
        body: json.encode(document),
        headers: _makeHeaders({}
          ..addAll(headers)
          ..addAll({'Content-Type': Document.mediaType}))));
    return Response.fromHttp(response, preferResource: true);
  }

  /// Updates the [resource] sending a PATCH request to the [url].
  updateResource(String url, Resource resource,
      {Map<String, String> headers = const {}}) async {
    final document = DataDocument.fromResource(resource, api: api);
    final response = await _exec((_) => _.patch(_makeUrl(url),
        body: json.encode(document),
        headers: _makeHeaders({}
          ..addAll(headers)
          ..addAll({'Content-Type': Document.mediaType}))));
    return Response.fromHttp(response, preferResource: true);
  }

  String _makeUrl(String url) => '${baseUrl}${url}';

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
      final response = await fn(client);
      _enforceContentType(response);
      return response;
    } finally {
      client.close();
    }
  }
}

typedef http.Client ClientFactory();

abstract class AuthorizationHeader {
  final key = 'Authorization';

  String get value;

  Map<String, String> get asMap => {key: value};
}

class AuthorizationHeaderBasic extends AuthorizationHeader {
  AuthorizationHeaderBasic(String username, String password)
      : value = base64.encode(utf8.encode('Basic ${username}:${password}'));

  final String value;
}

class AuthorizationHeaderBearer extends AuthorizationHeader {
  AuthorizationHeaderBearer(String token) : value = 'Bearer ${token}';

  final String value;
}
