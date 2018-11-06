import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('ResourceIdentifier', () {
    test('enforces naming rules on type', () {
      expect(() => Identifier('', '42'), throwsArgumentError);
      expect(() => Identifier(null, '42'), throwsArgumentError);
    });

    test('.id can not be empty or null', () {
      expect(() => Identifier('apples', ''), throwsArgumentError);
      expect(() => Identifier('apples', null), throwsArgumentError);
    });

    test('must contain type and id', () {
      final json = {"type": "apples", "id": "1"};
      expect(Identifier('apples', '1'), encodesToJson(json));
      expect(Identifier.fromJson(json), encodesToJson(json));
    });

    test('may contain meta', () {
      final json = {
        "type": "apples",
        "id": "1",
        "meta": {"count": "10"}
      };
      expect(Identifier('apples', '1', meta: {'count': '10'}),
          encodesToJson(json));
      expect(Identifier.fromJson(json), encodesToJson(json));
    });
  });
}
