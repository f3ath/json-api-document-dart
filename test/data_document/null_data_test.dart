import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  test('Minimal', () {
    expect(new Document.nullData(), encodesToJson({'data': null}));
  });

  test('Extended', () {
    final document = new Document.nullData(
      meta: {'purpose': 'test document'},
      self: new Link('/articles/1/relationships/author'),
      related: new Link.object(
        '/articles/1/author',
        {'purpose': 'test related link'},
      ),
      version: true,
    );
    expect(
        document,
        encodesToJson({
          'data': null,
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
    expect(() => new Document.nullData(meta: {'invalid key': 'foo'}),
        throwsArgumentError);
  });
}
