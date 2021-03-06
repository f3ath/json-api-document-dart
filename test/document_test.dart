import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/parser.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import 'helper.dart';

main() {
  final api = JsonApi(version: '1.0', meta: {'a': 'b'});
  final meta = {'foo': 'bar'};
  final parser = JsonApiParser();

  group('DataDocument', () {
    final related = Link(Uri.parse('/related'));
    final self = Link(Uri.parse('/self'));
    final first = Link(Uri.parse('/first'));
    final last = Link(Uri.parse('/last'));
    final prev = Link(Uri.parse('/prev'));
    final next = Link(Uri.parse('/next'));
    final pagination =
        Pagination(first: first, last: last, prev: prev, next: next);
    final appleId = IdentifierObject('apples', '42', meta: {'a': 'b'});
    final apple = ResourceObject('apples', '42',
        attributes: {'color': 'red'}, meta: {'a': 'b'});

    group('empty', () {
      test('minimal', () {
        final doc = Document.empty({"foo": "bar"});
        final json = {
          "meta": {"foo": "bar"}
        };
        expect(doc, encodesToJson(json));
        expect(
            parser.parseEmptyDocument(recodeJson(json)), encodesToJson(json));
      });

      test('full', () {
        final doc = Document.empty(meta, api: api);

        final json = {
          "meta": {"foo": "bar"},
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          }
        };
        expect(doc, encodesToJson(json));
        expect(
            parser.parseEmptyDocument(recodeJson(json)), encodesToJson(json));
      });
    });

    group('ToOne', () {
      test('minimal', () {
        final doc = Document(ToOne(null));
        final json = {"data": null};
        expect(doc, encodesToJson(json));
        expect(
            parser.parseToOneDocument(recodeJson(json)), encodesToJson(json));
      });

      test('full', () {
        final doc = Document(
          ToOne(appleId, self: self, related: related, included: [apple]),
          meta: meta,
          api: api,
        );
        final json = {
          "data": {
            "type": "apples",
            "id": "42",
            "meta": {"a": "b"}
          },
          "meta": {"foo": "bar"},
          "included": [
            {
              "type": "apples",
              "id": "42",
              "attributes": {"color": "red"}
            }
          ],
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
            "related": "/related",
          }
        };
        expect(doc, encodesToJson(json));
        expect(
            parser.parseToOneDocument(recodeJson(json)), encodesToJson(json));
      });
    });

    group('ToMany', () {
      test('minimal', () {
        final doc = Document(ToMany([]));
        final json = {"data": []};
        expect(doc, encodesToJson(json));
        expect(
            parser.parseToManyDocument(recodeJson(json)), encodesToJson(json));
      });

      test('full', () {
        final doc = Document(
          ToMany([appleId],
              self: self, related: related, pagination: pagination),
          meta: meta,
          api: api,
        );
        final json = {
          "data": [
            {
              "type": "apples",
              "id": "42",
              "meta": {"a": "b"}
            }
          ],
          "meta": {"foo": "bar"},
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
            "related": "/related",
            "first": "/first",
            "last": "/last",
            "prev": "/prev",
            "next": "/next",
          }
        };
        expect(doc, encodesToJson(json));
        expect(
            parser.parseToManyDocument(recodeJson(json)), encodesToJson(json));
      });
    });

    group('Resource', () {
      test('minimal', () {
        final doc = Document(ResourceData(apple));
        final json = {
          "data": {
            "type": "apples",
            "id": "42",
            "attributes": {"color": "red"}
          }
        };
        expect(doc, encodesToJson(json));
        expect(parser.parseResourceDocument(recodeJson(json)),
            encodesToJson(json));
      });

      test('full', () {
        final doc =
            Document(ResourceData(apple, self: self), api: api, meta: meta);
        final json = {
          "data": {
            "type": "apples",
            "id": "42",
            "attributes": {"color": "red"}
          },
          "meta": {"foo": "bar"},
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
          }
        };
        expect(doc, encodesToJson(json));
        expect(parser.parseResourceDocument(recodeJson(json)),
            encodesToJson(json));
      });
    });

    group('Resource Collection', () {
      test('minimal', () {
        final doc = Document(ResourceCollectionData([]));
        final json = {"data": []};
        expect(doc, encodesToJson(json));
        expect(parser.parseResourceCollectionDocument(recodeJson(json)),
            encodesToJson(json));
      });

      test('full', () {
        final doc = Document(
            ResourceCollectionData([apple], self: self, pagination: pagination),
            meta: meta,
            api: api);
        final json = {
          "data": [
            {
              "type": "apples",
              "id": "42",
              "attributes": {"color": "red"}
            }
          ],
          "meta": {"foo": "bar"},
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
            "first": "/first",
            "last": "/last",
            "prev": "/prev",
            "next": "/next",
          }
        };
        expect(doc, encodesToJson(json));
        expect(parser.parseResourceCollectionDocument(recodeJson(json)),
            encodesToJson(json));
      });
    });
  });

  group('ErrorDocument', () {
    final e = JsonApiError(
        id: 'id',
        about: Link(Uri.parse('/about')),
        status: 'Not Found',
        code: '404',
        title: 'Not Found',
        detail: 'We failed',
        sourcePointer: 'pntr',
        sourceParameter: 'prm',
        meta: {'foo': 'bar'});

    test('empty', () {
      final json = {"errors": []};
      expect(Document.error([]), encodesToJson(json));
      expect(parser.parseDocument(recodeJson(json), null), encodesToJson(json));
    });

    test('full', () {
      final json = {
        "errors": [
          {
            "id": "id",
            "links": {"about": "/about"},
            "status": "Not Found",
            "code": "404",
            "title": "Not Found",
            "detail": "We failed",
            "source": {"pointer": "pntr", "parameter": "prm"},
            "meta": {'foo': 'bar'}
          }
        ],
        "meta": {"foo": "bar"},
        "jsonapi": {
          "version": "1.0",
          "meta": {"a": "b"}
        }
      };

      final document = Document.error([e], meta: meta, api: api);
      expect(document.errors.first.title, 'Not Found');
      expect(document, encodesToJson(json));
      expect(parser.parseDocument(recodeJson(json), null), encodesToJson(json));
    });
  });
}
