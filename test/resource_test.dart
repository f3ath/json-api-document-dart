import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('Resource', () {
    test('enforces naming rules on type', () {
      expect(() => Resource('', '42'), throwsArgumentError);
      expect(() => Resource(null, '42'), throwsArgumentError);
    });

    test('.id can not be empty', () {
      expect(() => Resource('apples', ''), throwsArgumentError);
    });

    test('.id can be null', () {
      expect(Resource('apples', null), encodesToJson({"type": "apples"}));
    });

    test('may contain attributes', () {
      expect(
          Resource('apples', '42', attributes: Attributes({'foo': 'bar'})),
          encodesToJson({
            "type": "apples",
            "id": "42",
            "attributes": {"foo": "bar"}
          }));
    });

    test('may contain links', () {
      expect(
          Resource('apples', '42', self: Link('/apples/42')),
          encodesToJson({
            "type": "apples",
            "id": "42",
            "links": {"self": "/apples/42"}
          }));
    });

    test('may contain meta', () {
      expect(
          Resource('apples', '42', meta: {'foo': 'bar'}),
          encodesToJson({
            "type": "apples",
            "id": "42",
            "meta": {"foo": "bar"}
          }));
    });

//    test('may contain relationships', () {
//
//      expect(
//          Resource('articles', '1', attributes: Attributes(attributes)),
//          encodesToJson({
//            "type": "articles",
//            "id": "1",
//            "attributes": {
//              "title": "Rails is Omakase"
//            },
//            "relationships": {
//              "author": {
//                "links": {
//                  "self": "/articles/1/relationships/author",
//                  "related": "/articles/1/author"
//                },
//                "data": { "type": "people", "id": "9" }
//              }
//            }
//          }));
//    });
  });
}
