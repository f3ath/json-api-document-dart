import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  final apple = Resource('apples', '1');
  final orange = Resource('oranges', '2');
  final cart = Resource('carts', '2', relationships: {
    'goods': ToMany([Identifier.of(apple)])
  });
  final user = Resource('users', '3', relationships: {
    'carts': ToMany([Identifier.of(cart)])
  });

  group('Compound Document', () {
    test('Document without inluded resources is not compound', () {
      expect(DataDocument.fromNull().isCompound, false);
      expect(DataDocument.fromResource(apple).isCompound, false);
    });

    test('Document with inluded resources is compound', () {
      expect(DataDocument.fromResource(apple, included: [orange]).isCompound,
          true);
    });
  });

  group('Full linkage', () {
    test('A document without linked resources is fully linked', () {
      final doc = DataDocument.fromNull();
      expect(doc.isFullyLinked, true);
    });

    test('An empty document with a linked resource is not fully linked', () {
      final doc = DataDocument.fromResource(apple, included: [orange]);
      expect(doc.isFullyLinked, false);
    });

    test('An included resource may be identified by primary data', () {
      expect(
          DataDocument.fromIdentifier(Identifier.of(apple), included: [apple])
              .isFullyLinked,
          true);

      expect(
          DataDocument.fromIdentifierList([Identifier.of(apple)],
              included: [apple]).isFullyLinked,
          true);

      expect(DataDocument.fromResource(cart, included: [apple]).isFullyLinked,
          true);

      expect(
          DataDocument.fromResourceList([cart], included: [apple])
              .isFullyLinked,
          true);
    });

    test('An included resource may be identified by another included one', () {
      expect(
          DataDocument.fromResource(user, included: [cart, apple])
              .isFullyLinked,
          true);
    });
  });
}
