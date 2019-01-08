import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_api_document/json_api_document.dart';
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
  /// More details: https://jsonapi.org/format/#fetching-resources
  Future<Response> fetchResource(String url,
          {Map<String, String> headers = const {}}) async =>
      Response(await _exec((_) => _.get(_url(url), headers: _headers(headers))),
          preferResource: true);

  /// Fetches a [Document] containing identifier(s) from the given [url].
  /// Pass a [Map] of [headers] to add extra headers to the request.
  ///
  /// More details: https://jsonapi.org/format/#fetching-relationships
  fetchRelationship(String url,
          {Map<String, String> headers = const {}}) async =>
      Response(
          await _exec((_) => _.get(_url(url), headers: _headers(headers))));

  /// Creates a new [resource] sending a POST request to the [url].
  /// Pass a [Map] of [headers] to add extra headers to the request.
  ///
  /// More details: https://jsonapi.org/format/#crud-creating
  createResource(String url, Resource resource,
          {Map<String, String> headers = const {}}) async =>
      Response(
          await _exec((_) => _.post(_url(url),
              body: _body(resource),
              headers: _headers(headers, withContentType: true))),
          preferResource: true);

  /// Deletes the resource sending a DELETE request to the [url].
  /// Pass a [Map] of [headers] to add extra headers to the request.
  ///
  /// More details: https://jsonapi.org/format/#crud-deleting
  deleteResource(String url, {Map<String, String> headers = const {}}) async =>
      Response(
          await _exec((_) => _.delete(_url(url), headers: _headers(headers))));

  /// Updates the [resource] sending a PATCH request to the [url].
  /// Pass a [Map] of [headers] to add extra headers to the request.
  ///
  /// More details: https://jsonapi.org/format/#crud-updating
  updateResource(String url, Resource resource,
          {Map<String, String> headers = const {}}) async =>
      Response(
          await _exec((_) => _.patch(_url(url),
              body: _body(resource),
              headers: _headers(headers, withContentType: true))),
          preferResource: true);

  String _body(Resource resource) =>
      json.encode(DataDocument.fromResource(resource, api: api));

  String _url(String url) => '${baseUrl}${url}';

  Map<String, String> _headers(Map<String, String> headers,
      {bool withContentType = false}) {
    final h = <String, String>{}..addAll(defaultHeaders)..addAll(headers);
    if (withContentType) h['Content-Type'] = Document.mediaType;
    return h;
  }

  Future<http.Response> _exec(
      Future<http.Response> fn(http.Client client)) async {
    final client = clientFactory();
    try {
      return await fn(client);
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
