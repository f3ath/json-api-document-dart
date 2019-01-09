import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/src/resource_data.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import 'helpers.dart';

main() {
  group('DataDocument', () {
    final api = Api('1.0', meta: {'a': 'b'});
    final meta = {'foo': 'bar'};
    final self = Link('/self');
    final related = Link('/related');
    final first = Link('/first');
    final last = Link('/last');
    final prev = Link('/prev');
    final next = Link('/next');

    final appleId = Identifier('apples', '42');
    final appleIdWithMeta = Identifier('apples', '42', meta: {'a': 'b'});
    final apple = Resource('apples', '42', attributes: {'color': 'red'});
    final orange = Resource('oranges', '21', attributes: {'color': 'yellow'});

    group('with Null primary data', () {
      test('minimal', () {
        final doc = DataDocument.fromNull();
        final json = {"data": null};
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });

      test('full', () {
        final doc = DataDocument.fromNull(meta: meta, api: api, self: self);

        final json = {
          "data": null,
          "meta": {"foo": "bar"},
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
          }
        };
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });
    });

    group('with single Resource Identifier primary data', () {
      test('minimal', () {
        final doc = DataDocument.fromIdentifier(appleId);
        final json = {
          "data": {"type": "apples", "id": "42"}
        };
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });

      test('full', () {
        final doc = DataDocument.fromIdentifier(appleIdWithMeta,
            meta: meta,
            api: api,
            self: self,
            related: related,
            included: [apple]);
        final json = {
          "data": {
            "type": "apples",
            "id": "42",
            "meta": {"a": "b"}
          },
          "meta": {"foo": "bar"},
          "included": [
            {
              "type": "apples",
              "id": "42",
              "attributes": {"color": "red"}
            }
          ],
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
            "related": "/related",
          }
        };
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });
    });

    group('with multiple Resource Identifier primary data', () {
      test('minimal', () {
        final doc = DataDocument.fromIdentifierList(<Identifier>[]);
        final json = {"data": []};
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });

      test('full', () {
        final doc = DataDocument.fromIdentifierList(
          [appleIdWithMeta],
          meta: meta,
          api: api,
          self: self,
          related: related,
          first: first,
          last: last,
          prev: prev,
          next: next,
        );
        final json = {
          "data": [
            {
              "type": "apples",
              "id": "42",
              "meta": {"a": "b"}
            }
          ],
          "meta": {"foo": "bar"},
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
            "related": "/related",
            "first": "/first",
            "last": "/last",
            "prev": "/prev",
            "next": "/next",
          }
        };
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });
    });

    group('with single Resource primary data', () {
      test('minimal', () {
        final doc = DataDocument.fromResource(apple);
        final json = {
          "data": {
            "type": "apples",
            "id": "42",
            "attributes": {"color": "red"}
          }
        };
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });

      test('full', () {
        final doc = DataDocument.fromResource(
          apple,
          meta: meta,
          api: api,
          self: self,
        );
        final json = {
          "data": {
            "type": "apples",
            "id": "42",
            "attributes": {"color": "red"}
          },
          "meta": {"foo": "bar"},
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
          }
        };
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });
    });

    group('with multiple Resource primary data', () {
      test('minimal', () {
        final doc = DataDocument.fromResourceList([]);
        final json = {"data": []};
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });

      test('full', () {
        final doc = DataDocument.fromResourceList(
          [apple, orange],
          meta: meta,
          api: api,
          self: self,
          related: related,
          first: first,
          last: last,
          prev: prev,
          next: next,
        );
        final json = {
          "data": [
            {
              "type": "apples",
              "id": "42",
              "attributes": {"color": "red"}
            },
            {
              "type": "oranges",
              "id": "21",
              "attributes": {"color": "yellow"}
            }
          ],
          "meta": {"foo": "bar"},
          "jsonapi": {
            "version": "1.0",
            "meta": {"a": "b"}
          },
          "links": {
            "self": "/self",
            "related": "/related",
            "first": "/first",
            "last": "/last",
            "prev": "/prev",
            "next": "/next",
          }
        };
        expect(doc, encodesToJson(json));
        expect(DataDocument.fromJson(recodeJson(json)), encodesToJson(json));
      });
    });

    test('Can parse a primary resource with missing id', () {
      final doc = DataDocument.fromJson({
        'data': {'type': 'apples'}
      });
      expect(doc.data, TypeMatcher<ResourceData>());
      expect((doc.data as ResourceData).resource.type, 'apples');
      expect((doc.data as ResourceData).resource.id, null);
    });

    test('Can parse a primary resource with missing null id', () {
      final doc = DataDocument.fromJson({
        'data': {'type': 'apples', 'id': null}
      });
      expect(doc.data, TypeMatcher<ResourceData>());
      expect((doc.data as ResourceData).resource.type, 'apples');
      expect((doc.data as ResourceData).resource.id, null);
    });

    test('Treats ambiguous data as identifier unless forced', () {
      final singleElementJson = {
        'data': {'type': 'apples', 'id': '1'}
      };

      expect(DataDocument.fromJson(singleElementJson).data,
          TypeMatcher<IdentifierData>());

      expect(
          DataDocument.fromJson(singleElementJson, preferResource: true).data,
          TypeMatcher<ResourceData>());

      final multiElementJson = {
        'data': [
          {'type': 'apples', 'id': '1'},
          {'type': 'apples', 'id': '2'}
        ]
      };
      expect(DataDocument.fromJson(multiElementJson).data,
          TypeMatcher<IdentifierListData>());

      expect(DataDocument.fromJson(multiElementJson, preferResource: true).data,
          TypeMatcher<ResourceListData>());
    });
  });
}
