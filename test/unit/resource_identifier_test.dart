import 'package:json_api_document/json_api_document.dart';
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
  });
}
