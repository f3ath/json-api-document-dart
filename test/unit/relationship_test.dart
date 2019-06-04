import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../helper/recode_json.dart';

void main() {
  group('Decode/Encode', () {
    test('a complete ToOne', () {
      final json = recodeJson({
        'data': {'type': 'apples', 'id': '123'},
        'links': {
          'self': 'http://example.com/self',
          'related': 'http://example.com/related',
        },
        'meta': {'boo': false}
      });
      expect(Relationship.decodeJson(json), encodesToJson(json));
    });

    test('an empty ToOne', () {
      final json = recodeJson({'data': null});
      expect(Relationship.decodeJson(json), encodesToJson(json));
    });

    test('a complete ToMany', () {
      final json = recodeJson({
        'data': [{'type': 'apples', 'id': '123'}],
        'links': {
          'self': 'http://example.com/self',
          'related': 'http://example.com/related',
        },
        'meta': {'boo': false}
      });
      expect(Relationship.decodeJson(json), encodesToJson(json));
    });

    test('an empty ToMany', () {
      final json = recodeJson({'data': []});
      expect(Relationship.decodeJson(json), encodesToJson(json));
    });
  });
}
