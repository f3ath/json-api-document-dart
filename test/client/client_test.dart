import 'dart:convert';
import 'dart:io';

import 'package:json_api_document/json_api_client.dart';
import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

final appleResource = Resource('apples', '42');

expectSame(Document expected, Document actual) =>
    expect(json.encode(expected), json.encode(actual));

void main() {
  final client = JsonApiClient(baseUrl: 'http://localhost:4041');
  HttpServer server;

  setUp(() async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4041);
  });

  tearDown(() async {
    server.close(force: true);
  });

  group('fetch resource', () {
    test('200 with a document', () async {
      final doc = DataDocument.fromResource(appleResource);

      server.listen((rq) {
        expect(rq.method, 'GET');
        expect(rq.headers['foo'], ['bar']);
        expect(rq.uri.path, '/fetch');
        expect(rq.headers.host, 'localhost');
        expect(rq.headers.port, 4041);
        rq.response.headers.contentType = ContentType.parse(Document.mediaType);
        rq.response.write(json.encode(doc));
        rq.response.close();
      });

      final result = await client.fetch('/fetch', headers: {'foo': 'bar'});
      expectSame(doc, result.document);
      expect(
          (result.document as DataDocument).data, TypeMatcher<ResourceData>());
      expect(result.status, HttpStatus.ok);
    });

    test('404 without a document', () async {
      server.listen((rq) {
        rq.response.statusCode = HttpStatus.notFound;
        rq.response.headers.contentType = ContentType.parse(Document.mediaType);
        rq.response.close();
      });
      final result = await client.fetch('/fetch');
      expect(result.document, isNull);
      expect(result.status, HttpStatus.notFound);
    });

    test('invalid Content-Type', () async {
      server.listen((rq) {
        rq.response.close();
      });
      expect(() async => await client.fetch('/fetch'),
          throwsA(TypeMatcher<InvalidContentTypeException>()));
    });
  }, tags: ['vm-only']);

  group('fetch relationship', () {
    test('200 with a document', () async {
      final doc = DataDocument.fromResource(appleResource);

      server.listen((rq) {
        expect(rq.method, 'GET');
        expect(rq.headers['foo'], ['bar']);
        expect(rq.uri.path, '/fetch');
        expect(rq.headers.host, 'localhost');
        expect(rq.headers.port, 4041);
        rq.response.headers.contentType = ContentType.parse(Document.mediaType);
        rq.response.write(json.encode(doc));
        rq.response.close();
      });

      final result =
          await client.fetchRelationship('/fetch', headers: {'foo': 'bar'});
      expectSame(doc, result.document);
      expect((result.document as DataDocument).data,
          TypeMatcher<IdentifierData>());

      expect(result.status, HttpStatus.ok);
    }, tags: ['vm-only']);

    test('404 without a document', () async {
      server.listen((rq) {
        rq.response.statusCode = HttpStatus.notFound;
        rq.response.headers.contentType = ContentType.parse(Document.mediaType);
        rq.response.close();
      });
      final result = await client.fetchRelationship('/fetch');
      expect(result.document, isNull);
      expect(result.status, HttpStatus.notFound);
    });

    test('invalid Content-Type', () async {
      server.listen((rq) {
        rq.response.close();
      });
      expect(() async => await client.fetchRelationship('/fetch'),
          throwsA(TypeMatcher<InvalidContentTypeException>()));
    });
  });

  group('create', () {
    test('201 created', () async {
      server.listen((rq) async {
        expect(rq.method, 'POST');
        expect(rq.headers['foo'], ['bar']);
        expect(rq.headers.contentType.value, startsWith(Document.mediaType));
        expect(rq.headers['accept'].first, startsWith(Document.mediaType));
        expect(rq.uri.path, '/create');
        expect(rq.headers.host, 'localhost');
        expect(rq.headers.port, 4041);
        rq.response.headers.contentType = ContentType.parse(Document.mediaType);
        final doc = Document.fromJson(json.decode(await utf8.decodeStream(rq)));
        rq.response.statusCode = HttpStatus.created;
        rq.response.headers.add('location', 'http://example.com/');
        rq.response.write(json.encode(doc));
        rq.response.close();
      });

      final result = await client
          .createResource('/create', appleResource, headers: {'foo': 'bar'});
      expect(result.document, TypeMatcher<DataDocument>());
      expect((result.document as DataDocument).data.resources.first.toJson(),
          appleResource.toJson());
      expect(result.location, 'http://example.com/');
      expect(result.status, HttpStatus.created);
    });

    test('202 accepted', () async {
      server.listen((rq) async {
        rq.response.headers.contentType = ContentType.parse(Document.mediaType);
        rq.response.statusCode = HttpStatus.accepted;
        rq.response.close();
      });

      final result = await client.createResource('/create', appleResource);
      expect(result.document, isNull);
      expect(result.status, HttpStatus.accepted);
    });

    test('invalid Content-Type', () async {
      server.listen((rq) {
        rq.response.close();
      });

      expect(() async => await client.createResource('/test', appleResource),
          throwsA(TypeMatcher<InvalidContentTypeException>()));
    });
  }, tags: ['vm-only']);

//  group('update resource', () {
//    test('200 ok', () async {
//      final result = await client
//          .updateResource('/ok', appleResource, headers: {'foo': 'bar'});
//      expect(result.document, TypeMatcher<DataDocument>());
//      expect((result.document as DataDocument).data.resources.first.toJson(),
//          appleResource.toJson());
//      expect(result.status, HttpStatus.ok);
//      expect(result.document.meta['accept'].first, Document.mediaType);
//      expect(result.document.meta['content-type'].first,
//          startsWith(Document.mediaType));
//      expect(result.document.meta['foo'].first, 'bar');
//    });
//
//    test('invalid Content-Type', () async {
//      expect(
//          () async => await client.updateResource(
//              '/invalid_content_type', appleResource),
//          throwsA(TypeMatcher<InvalidContentTypeException>()));
//    });
//  });
//
//  group('update to-one relationship', () {
//    test('200 ok', () async {
//      final result = await client
//          .updateToOneRelationship('/ok', appleId01, headers: {'foo': 'bar'});
//      expect(result.document, TypeMatcher<DataDocument>());
//      expect((result.document as DataDocument).data.resources.first.toJson(),
//          appleId01.toJson());
//      expect(result.status, HttpStatus.ok);
//      expect(result.document.meta['accept'].first, Document.mediaType);
//      expect(result.document.meta['content-type'].first,
//          startsWith(Document.mediaType));
//      expect(result.document.meta['foo'].first, 'bar');
//    });
//
//    test('invalid Content-Type', () async {
//      expect(
//          () async => await client.updateToOneRelationship(
//              '/invalid_content_type', appleId01),
//          throwsA(TypeMatcher<InvalidContentTypeException>()));
//    });
//  });
//
//  group('delete to-one relationship', () {
//    test('200 ok', () async {
//      final result =
//          await client.deleteToOneRelationship('/ok', headers: {'foo': 'bar'});
//      expect(result.document, TypeMatcher<DataDocument>());
//      expect((result.document as DataDocument).data, TypeMatcher<NullData>());
//      expect(result.status, HttpStatus.ok);
//      expect(result.document.meta['accept'].first, Document.mediaType);
//      expect(result.document.meta['content-type'].first,
//          startsWith(Document.mediaType));
//      expect(result.document.meta['foo'].first, 'bar');
//    });
//
//    test('invalid Content-Type', () async {
//      expect(
//          () async => await client.updateToOneRelationship(
//              '/invalid_content_type', appleId01),
//          throwsA(TypeMatcher<InvalidContentTypeException>()));
//    });
//  });
}
