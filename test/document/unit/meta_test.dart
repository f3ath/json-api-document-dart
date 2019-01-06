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

    test('.containsKey()', () {
      expect(Meta({'foo': 'bar'}).containsKey('foo'), true);
      expect(Meta({'foo': 'bar'}).containsKey('xxx'), false);
    });

    test('.containsValue()', () {
      expect(Meta({'foo': 'bar'}).containsValue('bar'), true);
      expect(Meta({'foo': 'bar'}).containsValue('xxx'), false);
    });

    test('[]', () {
      expect(Meta({'foo': 'bar'})['foo'], 'bar');
      expect(Meta({'foo': 'bar'})['xxx'], null);
    });

    test('.entries', () {
      expect(Map.fromEntries(Meta({'foo': 'bar'}).entries), {'foo': 'bar'});
    });
  });
}
