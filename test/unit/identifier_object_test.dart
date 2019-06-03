import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../helper/recode_json.dart';

void main() {
  group('Decode/Encode', () {
    test('a complete object', () {
      final json = recodeJson({'type': 'apples', 'id': '123'});
      expect(IdentifierObject.decodeJson(json), encodesToJson(json));
    });
  });
}
