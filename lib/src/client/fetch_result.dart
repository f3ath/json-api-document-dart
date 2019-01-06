import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_api_document/json_api_document.dart';

/// A result of a fetch() request.
class FetchResult {
  FetchResult(http.Response response)
      : status = response.statusCode,
        headers = response.headers,
        document = response.contentLength > 0
            ? Document.fromJson(json.decode(response.body))
            : null;

  final Document document;

  final int status;
  final Map<String, String> headers;
}
