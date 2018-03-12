import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  test('Minimal', () {
    const expected = const {
      'meta': const {
        'foo': 'bar'}
    };

    final doc = new Document.fromMeta({'foo': 'bar'});

    expect(doc.toJson(), equals(expected));
  });

  test('Extended', () {
    var document = new Document.fromMeta(
        {'purpose': 'test document'},
        version: true,
        self: new Link('/articles/1/relationships/author'),
        related: new Link.object(
            '/articles/1/author', {'purpose': 'test related link'}));
    expect(
        document,
        encodesToJson({
          'jsonapi': {'version': '1.0'},
          'meta': {'purpose': 'test document'},
          'links': {
            'self': '/articles/1/relationships/author',
            'related': {
              'href': '/articles/1/author',
              'meta': {'purpose': 'test related link'}
            }
          }
        }),
        reason: 'Minimal Null-Data Document');
  });

  test('Meta fields are validated', () {
    expect(() => new Document.fromMeta({'invalid key': 'foo'}),
        throwsArgumentError);
  });

}
