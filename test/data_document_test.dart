import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  group('Null Data', () {
    test('Minimal', () {
      expect(new Document.nullData().toJson(), equals({'data': null}),
          reason: 'Minimal Null-Data Document');
    });

    test('Extended', () {
      var document = new Document.nullData(
          version: true,
          meta: {'purpose': 'test document'},
          self: new Link('/articles/1/relationships/author'),
          related: new Link.object(
              '/articles/1/author', {'purpose': 'test related link'})).toJson();
      expect(
          document,
          equals({
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
          }),
          reason: 'Minimal Null-Data Document');
    });

    test('Meta fields are validated', () {
      expect(() => new Document.nullData(meta: {'invalid key': 'foo'}),
          throwsArgumentError);
    });
  });
}
