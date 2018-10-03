import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('Document', () {
    final api = Api('1.0', meta: {'a': 'b'});
    final meta = {'foo': 'bar'};
    final self = Link('/self');

    group('with Null primary data', () {
      final minimal = DataDocument.fromNull();
      final full = DataDocument.fromNull(meta: meta, api: api, self: self);

      test('minimal', () {
        expect(minimal, encodesToJson({"data": null}));
      });

      test('full', () {
        expect(
            full,
            encodesToJson({
              "data": null,
              "meta": {"foo": "bar"},
              "jsonapi": {
                "version": "1.0",
                "meta": {"a": "b"}
              },
              "links": {
                "self": "/self",
              }
            }));
      });
    });

    group('with single Resource Identifier primary data', () {
      final identifier = Identifier('apples', '42');
      final minimal = DataDocument.fromIdentifier(identifier);
      final full = DataDocument.fromIdentifier(identifier,
          meta: meta, api: api, self: self);

      test('minimal', () {
        expect(
            minimal,
            encodesToJson({
              "data": {"type": "apples", "id": "42"}
            }));
      });

      test('full', () {
        expect(
            full,
            encodesToJson({
              "data": {"type": "apples", "id": "42"},
              "meta": {"foo": "bar"},
              "jsonapi": {
                "version": "1.0",
                "meta": {"a": "b"}
              },
              "links": {
                "self": "/self",
              }
            }));
      });
    });

    group('with multiple Resource Identifier primary data', () {
      final identifier = Identifier('apples', '42');
      final minimal = DataDocument.fromIdentifierList(<Identifier>[]);
      final full = DataDocument.fromIdentifierList([identifier],
          meta: meta, api: api, self: self);

      test('minimal', () {
        expect(minimal, encodesToJson({"data": []}));
      });

      test('full', () {
        expect(
            full,
            encodesToJson({
              "data": [
                {"type": "apples", "id": "42"}
              ],
              "meta": {"foo": "bar"},
              "jsonapi": {
                "version": "1.0",
                "meta": {"a": "b"}
              },
              "links": {
                "self": "/self",
              }
            }));
      });
    });
  });

  group('with single Resource primary data', () {
    final resource = Resource('apples', '42');
    final minimal = DataDocument.fromResource(resource);
//    final full = DataDocument.fromResource(resource,
//        meta: meta, api: api, self: self);

    test('minimal', () {
      expect(
          minimal,
          encodesToJson({
            "data": {"type": "apples", "id": "42"}
          }));
    });

//    test('full', () {
//      expect(
//          full,
//          encodesToJson({
//            "data": {"type": "apples", "id": "42"},
//            "meta": {"foo": "bar"},
//            "jsonapi": {
//              "version": "1.0",
//              "meta": {"a": "b"}
//            },
//            "links": {
//              "self": "http://self",
//            }
//          }));
//    });
  });
}
