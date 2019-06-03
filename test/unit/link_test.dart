import 'package:json_api_document/src/link.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../helper/recode_json.dart';

void main() {
  group('Decode/Encode', () {
    test('a simple link', () {
      final json = 'http://example.com';

      final link = Link.fromJson(recodeJson(json));
      expect(link, encodesToJson(json));
    });

    test('a link object', () {
      final json = {
        'href': 'http://example.com',
        'meta': {'meh': 123}
      };

      final link = Link.fromJson(recodeJson(json));
      expect(link, TypeMatcher<LinkObject>());
      expect(link, encodesToJson(json));
    });
  });
}
