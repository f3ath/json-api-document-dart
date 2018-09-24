import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('Document', () {
    final api = Api('1.0', meta: Meta({'a': 'b'}));
    final meta = Meta({'foo': 'bar'});
    final self = Link('http://self');

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
                "self": "http://self",
              }
            }));
      });
    });

    group('with single Resource Identifier primary data', () {
      final identifier = ResourceIdentifier('apples', '42');
      final minimal = DataDocument.fromResourceIdentifier(identifier);
      final full = DataDocument.fromResourceIdentifier(identifier,
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
                "self": "http://self",
              }
            }));
      });
    });

    group('with multiple Resource Identifier primary data', () {
      final identifier = ResourceIdentifier('apples', '42');
      final minimal =
          DataDocument.fromResourceIdentifierList(<ResourceIdentifier>[]);
      final full = DataDocument.fromResourceIdentifierList([identifier],
          meta: meta, api: api, self: self);

      test('minimal', () {
        expect(minimal, encodesToJson({"data": []}));
      });

      test('full', () {
        expect(
            full,
            encodesToJson({
              "data": [{"type": "apples", "id": "42"}],
              "meta": {"foo": "bar"},
              "jsonapi": {
                "version": "1.0",
                "meta": {"a": "b"}
              },
              "links": {
                "self": "http://self",
              }
            }));
      });
    });
  });
}
