import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../helper/recode_json.dart';

void main() {
  group('Decode/Encode', () {
    test('a complete object', () {
      final json = recodeJson({
        'version': '1.0',
        'meta': {'moo': 'true'}
      });
      expect(JsonApi.decodeJson(json), encodesToJson(json));
    });
  });
}