import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  test('Null documents encodes to something', () {
    final doc = new Document();
    expect(doc.toJson(), equals({'data': null}));
  });
}


