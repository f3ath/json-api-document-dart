import 'dart:convert';
import 'dart:io';

import 'package:json_api_document/json_api_document.dart';

final exampleResource = Resource('example', '123');

void handleRequest(HttpRequest rq) {
  final headers = Map<String, List<String>>();
  rq.headers.forEach((k, v) => headers[k] = v);
  final rs = rq.response;
  void write(Document d) => rs.write(json.encode(d));

  rs.headers.contentType = ContentType.parse(Document.mediaType);

  switch ('${rq.method} ${rq.uri.path}') {
    case 'GET /ok':
      rs.statusCode = HttpStatus.ok;
      write(DataDocument.fromResource(exampleResource, meta: headers));
      break;

    case 'GET /forbidden':
      rs.statusCode = HttpStatus.forbidden;
      write(ErrorDocument([ErrorObject(detail: 'nonono')]));
      break;

    case 'GET /invalid_content_type':
      rs.headers.contentType = ContentType('text', 'html');
      rs.statusCode = HttpStatus.ok;
      write(DataDocument.fromResource(exampleResource, meta: headers));
      break;

    default:
      rs.statusCode = HttpStatus.notFound;
  }

  rs.close();
}
