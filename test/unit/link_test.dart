import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  group('Link Object', () {
    test('encodes to JSON', () {
      expect(LinkObject('http://example.com'),
          encodesToJson({"href": "http://example.com"}));

      expect(
          LinkObject('http://example.com', meta: {'foo': 'bar'}),
          encodesToJson({
            "href": "http://example.com",
            "meta": {"foo": "bar"}
          }));
    });
  });
}
