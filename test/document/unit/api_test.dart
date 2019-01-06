import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  group('Api Document', () {
    test('can not be empty', () {
      expect(() => Api(null), throwsArgumentError);
    });

    test('.fromJson returns null on null input', () {
      expect(Api.fromJson(null), isNull);
    });
  });
}
