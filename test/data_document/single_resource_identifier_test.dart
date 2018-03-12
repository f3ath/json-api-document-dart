import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  test('Minimal', () {
    final document = new Document.fromResourceIdentifier(
        new ResourceIdentifier('apples', '1'));
    expect(
        document,
        encodesToJson({
          'data': {'type': 'apples', 'id': '1'}
        }));
  });

  test('Extended', () {
    final document = new Document.fromResourceIdentifier(
        new ResourceIdentifier('apples', '1'),
        version: true,
        meta: {'purpose': 'test document'},
        self: new Link('/purchases/1/relationships/cart'),
        related: new Link.object(
            '/purchases/1/cart', {'purpose': 'test related link'}));
    expect(
        document,
        encodesToJson({
          'data': {'type': 'apples', 'id': '1'},
          'jsonapi': {'version': '1.0'},
          'meta': {'purpose': 'test document'},
          'links': {
            'self': '/purchases/1/relationships/cart',
            'related': {
              'href': '/purchases/1/cart',
              'meta': {'purpose': 'test related link'}
            }
          }
        }));
  });

  test('Meta fields are validated', () {
    expect(
        () => new Document.fromResourceIdentifier(
            new ResourceIdentifier('apples', '1'),
            meta: {'invalid key': 'foo'}),
        throwsArgumentError);
  });
}
