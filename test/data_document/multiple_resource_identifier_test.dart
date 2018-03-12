import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  test('Minimal', () {
    final document = new Document.fromResourceIdentifierList([]);
    expect(document, encodesToJson({'data': []}));
  });

  test('Extended', () {
    final document = new Document.fromResourceIdentifierList(
        [
          new ResourceIdentifier('apples', '1'),
          new ResourceIdentifier('pears', '2'),
        ],
        version: true,
        meta: {'purpose': 'test document'},
        self: new Link('/purchases/1/relationships/cart'),
        related: new Link.object(
            '/purchases/1/cart', {'purpose': 'test related link'}));
    expect(
        document,
        encodesToJson({
          'data': [
            {'type': 'apples', 'id': '1'},
            {'type': 'pears', 'id': '2'},
          ],
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
        () => new Document.fromResourceIdentifierList([],
            meta: {'invalid key': 'foo'}),
        throwsArgumentError);
  });
}
