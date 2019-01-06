import 'package:json_api_document/src/document/identifier.dart';
import 'package:json_api_document/src/document/link.dart';
import 'package:json_api_document/src/document/relationships.dart';
import 'package:json_api_document/src/document/to_many.dart';
import 'package:json_api_document/src/document/to_one.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  group('Relationships', () {
    final json = {
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
    };

    test('.toJson()', () {
      final rel = Relationships({
        'author': ToOne(Identifier('people', '9'),
            self: Link('/articles/1/relationships/author'),
            related: Link('/articles/1/author')),
        'reviewer': ToOne(null),
        'comments': ToMany(
            [Identifier('comments', '5'), Identifier('comments', '12')],
            self: Link('/articles/1/relationships/comments'),
            related: Link('/articles/1/comments')),
        'tags': ToMany([])
      });
      expect(rel, encodesToJson(json));
    });

    test('.fromJson()', () {
      expect(Relationships.fromJson(json), encodesToJson(json));
    });
  });
}
