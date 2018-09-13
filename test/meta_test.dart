import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/src/meta.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  group('Meta', () {
    Meta meta;
    setUp(() {
      meta = Meta(StrictNaming(), {'foo': 'bar'});
    });
    test('checks member naming on assignment', () {
      expect(() => meta[''] = 'foo', throwsArgumentError);
    });
    test('encodes to JSON', () {
      expect(meta, encodesToJson({"foo": "bar"}));
    });
    test('can add and remove members', () {
      meta['a'] = true;
      expect(meta['a'], equals(true));
      meta.remove('foo');
      expect(meta['foo'], equals(null));
    });
    test('can not become empty', () {
      expect(() => meta.remove('foo'), throwsStateError);
    });
    test('values can be replaced', () {
      meta.replaceWith({'a': 'b'});
      expect(meta, encodesToJson({"a": "b"}));
    });
    test('values can not be replaced by an empty map', () {
      expect(() => meta.replaceWith({}), throwsArgumentError);
    });
    test('values can not be replaced by invalid values', () {
      expect(() => meta.replaceWith({'': true}), throwsArgumentError);
    });
  });
}
