import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../helper/recode_json.dart';

void main() {
  group('Decode/Encode', () {
    test('a complete error object', () {
      final json = recodeJson({
        'id': 'my_error',
        'links': {'about': 'http://example.com/my_error'},
        'status': '403',
        'code': 'ERR403',
        'title': 'Forbidden',
        'detail': 'More details here',
        'source': {'pointer': '/data', 'parameter': 'foo'},
        'meta': {'foo': 'bar'}
      });

      final error = JsonApiError.decodeJson(json);
      expect(error, encodesToJson(json));
    });

  });
}
