import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

main() {
  group('ResourceIdentifier', () {
    test('enforces naming rules on type', () {
      expect(() => ResourceIdentifier('', '42'), throwsArgumentError);
      expect(() => ResourceIdentifier(null, '42'), throwsArgumentError);
    });

    test('.id can not be empty or null', () {
      expect(() => ResourceIdentifier('apples', ''), throwsArgumentError);
      expect(() => ResourceIdentifier('apples', null), throwsArgumentError);
    });
  });
}
