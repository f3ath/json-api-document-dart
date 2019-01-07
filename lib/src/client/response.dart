import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_api_document/json_api_document.dart';

/// A result of a fetch() request.
class Response {
  Response(this.status, this.headers, this.document);

  Response.fromHttp(http.Response r, {bool preferResource = false})
      : this(
            r.statusCode,
            r.headers,
            r.contentLength > 0
                ? Document.fromJson(json.decode(r.body),
                    preferResource: preferResource)
                : null);

  final Document document;

  final int status;
  final Map<String, String> headers;

  String get location => headers['location'];
}
