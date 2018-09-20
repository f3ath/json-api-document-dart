import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('Document', () {
    group('with Null primary data', () {
      final api = Api('1.0', meta: Meta({'a': 'b'}));
      final meta = Meta({'foo': 'bar'});
      final self = Link('http://self');
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
  });
}


