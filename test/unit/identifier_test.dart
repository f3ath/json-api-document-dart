import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  group('Invariants', () {
    test('type can not be null', () {
      expect(() => Identifier(null, '123'), throwsArgumentError);
    });
    test('type can not be empty', () {
      expect(() => Identifier('', '123'), throwsArgumentError);
    });
    test('id can not be null', () {
      expect(() => Identifier('apples', null), throwsArgumentError);
    });
    test('id can not be empty', () {
      expect(() => Identifier('apples', ''), throwsArgumentError);
    });
  });

  test('Equality', () {
    expect(Identifier('foo', '123').equals(Identifier('foo', '123')), true);
    expect(Identifier('foo', '123').equals(Identifier('bar', '123')), false);
    expect(Identifier('foo', '123').equals(Identifier('foo', '42')), false);
  });
}
