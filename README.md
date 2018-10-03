# JSON API (jsonapi, see https://jsonapi.org) Document model

The goal of this library is to provide a transparent way to build JSON API Documents.
- A JSON API Document is an immutable value object which can be converted to JSON using `JSON.encode()`
- All JSON API Documents are guaranteed to comply with [JSON API v1.0](http://jsonapi.org/format/)

## Installation
From [pub.dartlang.org](https://pub.dartlang.org/packages/json_api_document#-installing-tab-)

## Documentation
Documentation is being developed. To get a sense of what the API looks like,
take a look at the [example](test/specification_example_test.dart):

```dart
import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  test('Can build the example from http://jsonapi.org/', () {
    final dan = Resource('people', '9',
        attributes: {
          'first-name': 'Dan',
          'last-name': 'Gebhardt',
          'twitter': 'dgeb'
        },
        self: Link('http://example.com/people/9'));

    final firstComment = Resource('comments', '5',
        attributes: {'body': 'First!'},
        relationships: {'author': ToOne(Identifier('people', '2'))},
        self: Link('http://example.com/comments/5'));

    final secondComment = Resource('comments', '12',
        attributes: {'body': 'I like XML better'},
        relationships: {'author': ToOne(dan.toIdentifier())},
        self: Link('http://example.com/comments/12'));

    final article = Resource(
      'articles',
      '1',
      self: Link('http://example.com/articles/1'),
      attributes: {'title': 'JSON API paints my bikeshed!'},
      relationships: {
        'author': ToOne(
          dan.toIdentifier(),
          self: Link('http://example.com/articles/1/relationships/author'),
          related: Link('http://example.com/articles/1/author'),
        ),
        'comments': ToMany(
            [firstComment.toIdentifier(), secondComment.toIdentifier()],
            self: Link('http://example.com/articles/1/relationships/comments'),
            related: Link('http://example.com/articles/1/comments'))
      },
    );

    final doc = DataDocument.fromResourceList([article],
        self: Link('http://example.com/articles'),
        next: Link('http://example.com/articles?page[offset]=2'),
        last: Link('http://example.com/articles?page[offset]=10'),
        included: [dan, firstComment, secondComment]);

    expect(
        doc,
        encodesToJson({
          "links": {
            "self": "http://example.com/articles",
            "next": "http://example.com/articles?page[offset]=2",
            "last": "http://example.com/articles?page[offset]=10"
          },
          "data": [
            {
              "type": "articles",
              "id": "1",
              "attributes": {"title": "JSON API paints my bikeshed!"},
              "relationships": {
                "author": {
                  "links": {
                    "self":
                        "http://example.com/articles/1/relationships/author",
                    "related": "http://example.com/articles/1/author"
                  },
                  "data": {"type": "people", "id": "9"}
                },
                "comments": {
                  "links": {
                    "self":
                        "http://example.com/articles/1/relationships/comments",
                    "related": "http://example.com/articles/1/comments"
                  },
                  "data": [
                    {"type": "comments", "id": "5"},
                    {"type": "comments", "id": "12"}
                  ]
                }
              },
              "links": {"self": "http://example.com/articles/1"}
            }
          ],
          "included": [
            {
              "type": "people",
              "id": "9",
              "attributes": {
                "first-name": "Dan",
                "last-name": "Gebhardt",
                "twitter": "dgeb"
              },
              "links": {"self": "http://example.com/people/9"}
            },
            {
              "type": "comments",
              "id": "5",
              "attributes": {"body": "First!"},
              "relationships": {
                "author": {
                  "data": {"type": "people", "id": "2"}
                }
              },
              "links": {"self": "http://example.com/comments/5"}
            },
            {
              "type": "comments",
              "id": "12",
              "attributes": {"body": "I like XML better"},
              "relationships": {
                "author": {
                  "data": {"type": "people", "id": "9"}
                }
              },
              "links": {"self": "http://example.com/comments/12"}
            }
          ]
        }));
  });
}

```
