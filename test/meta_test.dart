import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  group('Meta', () {

    test('can not be created empty', () {
      expect(() => Meta({}), throwsArgumentError);
    });

    test('can merge', () {
      final first = Meta({'a': 'first', 'b': 'first'});
      final second = Meta({'b': 'second', 'c': 'second'});
      final merged = first | second;
      expect(merged['a'], equals('first'));
      expect(merged['b'], equals('first'));
      expect(merged['c'], equals('second'));
    });

    test('enforces naming', () {
      expect(() => Meta({'': true}), throwsArgumentError);
    });

    test('can remove an item', () {
      expect(Meta({'a': true, 'b':true}).remove('a')['a'], equals(null));
    });

    test('encodes to JSON', () {
      expect(Meta({'foo': 'bar'}), encodesToJson({"foo": "bar"}));
    });
  });
}
