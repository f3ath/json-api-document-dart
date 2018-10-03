import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  group('Full linkage', () {
    test('A document without linked resources is fully linked', () {
      final doc = DataDocument.fromNull();
      expect(doc.isFullyLinked, equals(true));
    });

    test('An empty document with a linked resource is not fully linked', () {
      final apple = Resource('apples', '1');
      final orange = Resource('oranges', '2');
      final doc = DataDocument.fromResource(apple, included: [orange]);
      expect(doc.isFullyLinked, equals(false));
    });

    test('An included resource may be identified by primary data', () {
      final apple = Resource('apples', '1');
      final cart = Resource('carts', '2', relationships: {
        'goods': ToMany([Identifier.of(apple)])
      });

      expect(
          DataDocument.fromIdentifier(Identifier.of(apple), included: [apple])
              .isFullyLinked,
          equals(true));

      expect(
          DataDocument.fromIdentifierList([Identifier.of(apple)],
              included: [apple]).isFullyLinked,
          equals(true));

      expect(DataDocument.fromResource(cart, included: [apple]).isFullyLinked,
          equals(true));

      expect(
          DataDocument.fromResourceList([cart], included: [apple])
              .isFullyLinked,
          equals(true));
    });
  });
}
