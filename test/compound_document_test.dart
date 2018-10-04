import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  group('Full linkage', () {
    test('A document without linked resources is fully linked and not compound',
        () {
      final doc = DataDocument.fromNull();
      expect(doc.isCompound, false);
      expect(doc.isFullyLinked, true);
    });

    test(
        'An empty document with a linked resource is not fully linked and compound',
        () {
      final apple = Resource('apples', '1');
      final orange = Resource('oranges', '2');
      final doc = DataDocument.fromResource(apple, included: [orange]);
      expect(doc.isCompound, true);
      expect(doc.isFullyLinked, false);
    });

    test('An included resource may be identified by primary data', () {
      final apple = Resource('apples', '1');
      final cart = Resource('carts', '2', relationships: {
        'goods': ToMany([Identifier.of(apple)])
      });

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
  });
}
