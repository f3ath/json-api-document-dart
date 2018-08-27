import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';
import 'package:json_matcher/json_matcher.dart';

void main() {
  group('Meta Document', () {
    final emptyDoc = Document();
    final nonEmptyDoc = (Document()..meta['foo'] = 'bar');
    final nonEmptyDocJson = {
      "meta": {"foo": "bar"},
      "jsonapi": {"version": "1.0"}
    };
    test('is invalid upon creation', () {
      expect(emptyDoc.isValid, equals(false));
      expect(() => emptyDoc.toJson(), throwsStateError);
    });
    test('becomes valid with a non empty meta', () {
      expect(nonEmptyDoc.isValid, equals(true));
      expect(nonEmptyDoc, encodesToJson(nonEmptyDocJson));
    });
    test('jsonapi may have meta', () {
      final doc = new Document()
        ..meta['foo'] = 'bar'
        ..jsonapi.meta['a'] = 'b';

      expect(
          doc,
          encodesToJson({
            "meta": {"foo": "bar"},
            "jsonapi": {
              "version": "1.0",
              "meta": {"a": "b"}
            }
          }));
    });
  });
}
