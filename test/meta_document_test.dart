import 'package:json_api_document/json_api_document.dart';
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
}
