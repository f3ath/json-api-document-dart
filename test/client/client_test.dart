import 'dart:io';

import 'package:json_api_document/json_api_client.dart';
import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/src/test_server.dart';
import 'package:test/test.dart';

void main() {
  final client = JsonApiClient(baseUrl: 'http://localhost:4041');
  HttpServer server;

  setUpAll(() async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4041);
    server.listen(handleRequest);
  });

  tearDownAll(() async {
    server.close(force: true);
  });

  group('fetch', () {
    test('200 with a document', () async {
      final result = await client.fetch('/ok', headers: {'foo': 'bar'});
      expect(result.document, TypeMatcher<DataDocument>());
      expect(result.status, HttpStatus.ok);
      expect(result.document.meta['accept'].first, Document.mediaType);
      expect(result.document.meta['foo'].first, 'bar');
    });

    test('404 without document', () async {
      final result = await client.fetch('/not_found');
      expect(result.document, isNull);
      expect(result.status, HttpStatus.notFound);
    });

    test('403 with a document', () async {
      final result = await client.fetch('/forbidden');
      expect(result.document, TypeMatcher<ErrorDocument>());
      expect(result.status, HttpStatus.forbidden);
    });

    test('invalid Content-Type', () async {
      expect(() async => await client.fetch('/invalid_content_type'),
          throwsA(TypeMatcher<InvalidContentTypeException>()));
    });
  });

  group('create', () {
    final newApple = Resource('apples', null);
    test('201 created', () async {
      final result =
          await client.create('/apples', newApple, headers: {'foo': 'bar'});
//      expect(result.document, TypeMatcher<DataDocument>());
//      expect(result.status, HttpStatus.ok);
//      expect(result.document.meta['accept'].first, Document.mediaType);
//      expect(result.document.meta['foo'].first, 'bar');
    });

    test('invalid Content-Type', () async {
      expect(() async => await client.fetch('/invalid_content_type'),
          throwsA(TypeMatcher<InvalidContentTypeException>()));
    });
  });
}
