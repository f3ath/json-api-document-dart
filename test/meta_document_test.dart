import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/src/api.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/meta.dart';
import 'package:test/test.dart';
import 'package:json_matcher/json_matcher.dart';

void main() {
  group('Meta Document', () {
    test('can not be created with null meta', () {
      expect(() => MetaDocument(null), throwsArgumentError);
    });

    test('minimal', () {
      final doc = MetaDocument(Meta({'foo': 'bar'}));
      expect(doc.meta, TypeMatcher<Meta>());
      expect(doc.api, equals(null));
      expect(doc.self, equals(null));
      expect(
          doc,
          encodesToJson({
            "meta": {"foo": "bar"}
          }));
    });

    test('full', () {
      final doc = MetaDocument(Meta({'foo': 'bar'}),
          api: Api('1.0', meta: Meta({'a': 'b'})), self: Link('http://self'));
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
  });
}
