import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  test('Minimal', () {
    final document = new Document.fromResourceList([]);
    expect(document, encodesToJson({'data': []}));
  });

  test('Extended', () {
    final document = new Document.fromResourceList(
        [
          new Resource('apples', '1',
              attributes: {'color': 'red', 'sort': 'Fuji'}),
          new Resource('apples', '2',
              attributes: {'color': 'yellow', 'sort': 'Honeycrisp'}),
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
            {
              'type': 'apples',
              'id': '1',
              'attributes': {'color': 'red', 'sort': 'Fuji'}
            },
            {
              'type': 'apples',
              'id': '2',
              'attributes': {'color': 'yellow', 'sort': 'Honeycrisp'}
            },
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
        () => new Document.fromResourceList([], meta: {'invalid key': 'foo'}),
        throwsArgumentError);
  });
}
