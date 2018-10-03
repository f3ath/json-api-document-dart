import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('DataDocument', () {
    final api = Api('1.0', meta: {'a': 'b'});
    final meta = {'foo': 'bar'};
    final self = Link('/self');

    group('with Null primary data', () {
      test('minimal', () {
        final doc = DataDocument.fromNull();
        expect(doc, encodesToJson({"data": null}));
      });

      test('full', () {
        final doc = DataDocument.fromNull(meta: meta, api: api, self: self);
        expect(
            doc,
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
      final apple = Identifier('apples', '42');

      test('minimal', () {
        final doc = DataDocument.fromIdentifier(apple);
        expect(
            doc,
            encodesToJson({
              "data": {"type": "apples", "id": "42"}
            }));
      });

      test('full', () {
        final doc = DataDocument.fromIdentifier(apple,
            meta: meta, api: api, self: self);
        expect(
            doc,
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
      final apple = Identifier('apples', '42');

      test('minimal', () {
        final doc = DataDocument.fromIdentifierList(<Identifier>[]);
        expect(doc, encodesToJson({"data": []}));
      });

      test('full', () {
        final doc = DataDocument.fromIdentifierList([apple],
            meta: meta, api: api, self: self);
        expect(
            doc,
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

    group('with single Resource primary data', () {
      final apple = Resource('apples', '42', attributes: {'color': 'red'});

      test('minimal', () {
        final doc = DataDocument.fromResource(apple);
        expect(
            doc,
            encodesToJson({
              "data": {
                "type": "apples",
                "id": "42",
                "attributes": {"color": "red"}
              }
            }));
      });

      test('full', () {
        final doc =
            DataDocument.fromResource(apple, meta: meta, api: api, self: self);
        expect(
            doc,
            encodesToJson({
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
            }));
      });
    });
  });
}
