import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  group('Meta', () {
    test('can not be empty', () {
      expect(() => Meta({}), throwsArgumentError);
    });

    test('enforces naming', () {
      expect(() => Meta({'': true}), throwsArgumentError);
    });

    test('encodes to JSON', () {
      expect(Meta({'foo': 'bar'}), encodesToJson({"foo": "bar"}));
    });
  });
}
