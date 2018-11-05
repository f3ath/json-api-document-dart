import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  group('Link.fromJson()', () {
    test('returns a Link when given a string', () {
      final link = Link.fromJson('http://example.com');
      expect(link, TypeMatcher<Link>());
      expect(link.url, 'http://example.com');
    });

    test('returns a LinkObject', () {
      final link = Link.fromJson({'href': 'http://example.com'});
      if (link is LinkObject) {
        expect(link.url, 'http://example.com');
        expect(link.meta, isNull);
      } else {
        fail('not an object');
      }
    });

    test('returns a LinkObject with a Meta', () {
      final link = Link.fromJson({
        'href': 'http://example.com',
        'meta': {'foo': 'bar'}
      });
      if (link is LinkObject) {
        expect(link.url, 'http://example.com');
        expect(link.meta['foo'], 'bar');
      } else {
        fail('not an object');
      }
    });

    test('throws CastError', () {
      expect(() => Link.fromJson(true), throwsFormatException);
    });
  });

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
