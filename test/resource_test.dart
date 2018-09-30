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
      expect(Resource('apples', '42', attributes: {'foo': 'bar'}), encodesToJson({"type": "apples"}));

    });
  });
}
