import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  test('Minimal', () {
    final document = new Document.fromResource(new Resource('apples', '1'));
    expect(
        document,
        encodesToJson({
          'data': {'type': 'apples', 'id': '1'}
        }));
  });

  test('Extended', () {
    final document = new Document.fromResource(
        new Resource('apples', '1',
            attributes: {'color': 'red', 'sort': 'Fuji'}),
        version: true,
        meta: {'purpose': 'test document'},
        self: new Link('/articles/1/relationships/author'),
        related: new Link.object(
            '/articles/1/author', {'purpose': 'test related link'}));
    expect(
        document,
        encodesToJson({
          'data': {
            'type': 'apples',
            'id': '1',
            'attributes': {'color': 'red', 'sort': 'Fuji'}
          },
          'jsonapi': {'version': '1.0'},
          'meta': {'purpose': 'test document'},
          'links': {
            'self': '/articles/1/relationships/author',
            'related': {
              'href': '/articles/1/author',
              'meta': {'purpose': 'test related link'}
            }
          }
        }));
  });

  test('Meta fields are validated', () {
    expect(
        () => new Document.fromResource(new Resource('apples', '1'),
            meta: {'invalid key': 'foo'}),
        throwsArgumentError);
  });
}
