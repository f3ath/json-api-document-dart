import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  group('Meta Document', () {
    test('can not be created with null meta', () {
      expect(() => MetaDocument(null), throwsArgumentError);
    });

    test('minimal example', () {
      final doc = MetaDocument({'foo': 'bar'});
      expect(doc.meta, TypeMatcher<Meta>());
      expect(doc.api, equals(null));
      expect(doc.self, equals(null));
      expect(
          doc,
          encodesToJson({
            "meta": {"foo": "bar"}
          }));
    });

    test('full example', () {
      final doc = MetaDocument({'foo': 'bar'},
          api: Api('1.0', meta: {'a': 'b'}), self: Link('http://self'));
      expect(doc.meta, TypeMatcher<Meta>());
      expect(doc.api, TypeMatcher<Api>());
      expect(doc.self, TypeMatcher<Link>());
      expect(
          doc,
          encodesToJson({
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

    test('can be parsed from json', () {
      final doc = Document.fromJson({
        "meta": {"foo": "bar"},
        "jsonapi": {
          "version": "1.0",
          "meta": {"a": "b"}
        },
        "links": {
          "self": "http://self",
        }
      });

      expect(doc, TypeMatcher<MetaDocument>());
      expect(doc.meta.toMap(), equals({"foo": "bar"}));
      expect(doc.api.version, equals('1.0'));
      expect(doc.api.meta.toMap(), equals({"a": "b"}));
      expect(doc.self.url, equals('http://self'));
    });
  });
}
