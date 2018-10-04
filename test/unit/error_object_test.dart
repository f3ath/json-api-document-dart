import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('Error', () {
    final empty = ErrorObject();
    final full = ErrorObject(
        id: 'id',
        about: Link('/about'),
        status: 'Not found',
        code: '404',
        title: 'Not found',
        detail: 'We failed',
        pointer: 'pntr',
        parameter: 'prm',
        meta: {'foo': 'bar'});

    test('empty', () {
      expect(empty, encodesToJson({}));
    });

    test('full', () {
      expect(
          full,
          encodesToJson({
            "id": "id",
            "links": {"about": "/about"},
            "status": "Not found",
            "code": "404",
            "title": "Not found",
            "detail": "We failed",
            "source": {"pointer": "pntr", "parameter": "prm"},
            "meta": {'foo': 'bar'}
          }));
    });
  });
}
