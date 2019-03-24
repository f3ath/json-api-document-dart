import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/validator.dart';
import 'package:test/test.dart';

void main() {
  final apple = ResourceObject('apples', '1');
  final orange = ResourceObject('oranges', '2');
  final cart = ResourceObject('carts', '2', relationships: {
    'goods': ToMany([IdentifierObject('apples', '1')])
  });
  final user = ResourceObject('users', '3', relationships: {
    'carts': ToMany([IdentifierObject('carts', '2')])
  });

  final validator = JsonApiValidator();

  group('Full linkage', () {
    test('A document without included resources is fully linked', () {
      final data = ResourceData(apple);
      expect(data.isFullyLinked, true);
    });

    test('An empty document with a linked resource is not fully linked', () {
      expect(
          ResourceCollectionData([], included: [orange]).isFullyLinked, false);
      expect(ToMany([], included: [orange]).isFullyLinked, false);
      expect(ToOne(null, included: [orange]).isFullyLinked, false);
    });

    test('An included resource may be identified by primary data', () {
      expect(ResourceData(cart, included: [apple]).isFullyLinked, true);

      expect(
          ToOne(IdentifierObject('apples', '1'), included: [apple])
              .isFullyLinked,
          true);

      expect(ResourceCollectionData([cart], included: [apple]).isFullyLinked,
          true);

      expect(
          ToMany([IdentifierObject('apples', '1')], included: [apple])
              .isFullyLinked,
          true);
    });

    test('An included resource may be identified by another included one', () {
      expect(ResourceData(user, included: [cart, apple]).isFullyLinked, true);
    });
  });

  test('Can not include more that one resource with the same type and id', () {
    final sameApple = ResourceObject(apple.type, apple.id);
    final errors = validator
        .dataErrors(ResourceData(user, included: [apple, cart, sameApple]));
    expect(errors.length, 1);
    expect(
        errors.first.message, 'Resource apples:1 is included multiple times');
  });

  test('Can not include primary resource', () {
    final sameUser = ResourceObject(user.type, user.id);
    final errors =
        validator.dataErrors(ResourceData(user, included: [sameUser]));
    expect(errors.length, 1);
    expect(errors.first.message, 'Primary resource users:3 is also included');
  });
}
