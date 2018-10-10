import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

main() {
  group('Resource', () {
    test('enforces naming rules on type', () {
      expect(() => Resource('', '42'), throwsArgumentError);
      expect(() => Resource(null, '42'), throwsArgumentError);
    });

    test('.id can not be empty', () {
      expect(() => Resource('apples', ''), throwsArgumentError);
    });

    test('.id can be null', () {
      expect(Resource('apples', null), encodesToJson({"type": "apples"}));
    });

    test('may contain attributes', () {
      expect(
          Resource('apples', '42', attributes: {'foo': 'bar'}),
          encodesToJson({
            "type": "apples",
            "id": "42",
            "attributes": {"foo": "bar"}
          }));
    });

    test('may contain links', () {
      expect(
          Resource('apples', '42', self: Link('/apples/42')),
          encodesToJson({
            "type": "apples",
            "id": "42",
            "links": {"self": "/apples/42"}
          }));
    });

    test('may contain meta', () {
      expect(
          Resource('apples', '42', meta: {'foo': 'bar'}),
          encodesToJson({
            "type": "apples",
            "id": "42",
            "meta": {"foo": "bar"}
          }));
    });

    test('may contain relationships', () {
      expect(
          Resource('articles', '1', attributes: {
            'title': 'Hello world'
          }, relationships: {
            'author': ToOne(Identifier('people', '9'),
                self: Link('/articles/1/relationships/author'),
                related: Link('/articles/1/author')),
            'reviewer': ToOne(null),
            'comments': ToMany(
                [Identifier('comments', '5'), Identifier('comments', '12')],
                self: Link('/articles/1/relationships/comments'),
                related: Link('/articles/1/comments')),
            'tags': ToMany([])
          }),
          encodesToJson({
            "type": "articles",
            "id": "1",
            "attributes": {"title": "Hello world"},
            "relationships": {
              "author": {
                "links": {
                  "self": "/articles/1/relationships/author",
                  "related": "/articles/1/author"
                },
                "data": {"type": "people", "id": "9"}
              },
              "reviewer": {"data": null},
              "tags": {"data": []},
              "comments": {
                "links": {
                  "self": "/articles/1/relationships/comments",
                  "related": "/articles/1/comments"
                },
                "data": [
                  {"type": "comments", "id": "5"},
                  {"type": "comments", "id": "12"}
                ]
              }
            }
          }));
    });

    test('"id" and "type" can not be used as a relationship name', () {
      expect(
          () => Resource('articles', '1', relationships: {
                'id': ToOne(null),
              }),
          throwsArgumentError);
      expect(
          () => Resource('articles', '1', relationships: {
                'type': ToOne(null),
              }),
          throwsArgumentError);
    });

    test('Resource fields must be unique', () {
      expect(
          () => Resource('articles', '1', attributes: {
                'foo': 'bar'
              }, relationships: {
                'foo': ToOne(null),
              }),
          throwsArgumentError);
    });
  });
}
