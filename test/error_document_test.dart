import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  test('Error Document', () {
    final doc = new Document.fromErrors([
      new ErrorObject(
          id: '1',
          about: new Link('/errors/not_found'),
          status: '404',
          code: 'not_found',
          title: 'Resource not found',
          detail: 'We tried hard but could not find anything',
          pointer: '/data',
          parameter: 'query_string',
          meta: {'purpose': 'test'}),
    ], meta: {
      'purpose': 'test'
    }, version: true);
    expect(
        doc.toJson(),
        equals({
          'errors': [
            {
              'id': '1',
              'links': {'about': '/errors/not_found'},
              'status': '404',
              'code': 'not_found',
              'title': 'Resource not found',
              'detail': 'We tried hard but could not find anything',
              'source': {'pointer': '/data', 'parameter': 'query_string'},
              'meta': {'purpose': 'test'}
            }
          ],
          'meta': {'purpose': 'test'},
          'jsonapi': {'version': '1.0'}
        }));
  });
}
