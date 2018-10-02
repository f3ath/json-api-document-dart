import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('ErrorDocument', () {
    final one = ErrorObject(id: 'one');
    final two = ErrorObject(id: 'two');
    final empty = ErrorDocument(<ErrorObject>[]);
    final api = Api('1.0', meta: {'a': 'b'});
    final meta = {'foo': 'bar'};
    final self = Link('http://self');
    final full = ErrorDocument([one, two], meta: meta, api: api, self: self);

    test('empty', () {
      expect(empty, encodesToJson({"errors": []}));
    });

    test('full', () {
      expect(
          full,
          encodesToJson({
            "errors": [
              {"id": "one"},
              {"id": "two"}
            ],
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

    test('.errors contains list of errors', () {
      expect(full.errors, equals([one, two]));
    });

    test('.api contains JSON API Object', () {
      expect(full.api, equals(api));
    });

    test('.meta contains Meta Object', () {
      expect(full.meta.toMap(), equals(meta));
    });

    test('.self contains self Link', () {
      expect(full.self, equals(self));
    });
  });
}
