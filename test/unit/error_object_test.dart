import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('ErrorObject', () {
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

    test('fromJson() (empty object)', () {
      final eo = ErrorObject.fromJson({});
      expect(eo, TypeMatcher<ErrorObject>());
      expect(eo.id, isNull);
      expect(eo.code, isNull);
    });

    test('fromJson() (partial object)', () {
      final eo = ErrorObject.fromJson({
        'detail': 'We failed',
        'source': {'parameter': 'foo'}
      });
      expect(eo, TypeMatcher<ErrorObject>());
      expect(eo.detail, 'We failed');
      expect(eo.parameter, 'foo');
      expect(eo.pointer, isNull);
      expect(eo.status, isNull);
    });

    test('.fromJson() (full object)', () {
      final json = {
        "id": "id",
        "links": {"about": "/about"},
        "status": "Not found",
        "code": "404",
        "title": "Not found",
        "detail": "We failed",
        "source": {"pointer": "pntr", "parameter": "prm"},
        "meta": {'foo': 'bar'}
      };
      expect(ErrorObject.fromJson(json), encodesToJson(json));
    });
  });
}
