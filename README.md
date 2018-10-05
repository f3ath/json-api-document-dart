# [JSON API](http://jsonapi.org) Document model and parser

The goal of this library is to provide a transparent way to build and parse JSON API Documents.

These are the key values of the library:
- **Immutability**. Produced documents are immutable value objects.
- **Native JSON support**. Use the built-in `json.encode()` to convert to a JSON string.
- **Strict standard compliance**. All JSON API Documents are guaranteed to follow [JSON API v1.0](http://jsonapi.org/format/).


## Documentation
To get a sense of what the library API looks like, take a look at the [example](example/main.dart):

```dart
import 'dart:convert';

import 'package:json_api_document/json_api_document.dart';

/// The following function produces the example document
/// from the first page of http://jsonapi.org/.
Document makeJsonApiResponse() {
  final dan = Resource('people', '9',
      attributes: {
        'first-name': 'Dan',
        'last-name': 'Gebhardt',
        'twitter': 'dgeb'
      },
      self: Link('http://example.com/people/9'));

  final personIdentifier = Identifier('people', '2');

  final firstComment = Resource('comments', '5',
      attributes: {'body': 'First!'},
      relationships: {'author': ToOne(personIdentifier)},
      self: Link('http://example.com/comments/5'));

  final secondComment = Resource('comments', '12',
      attributes: {'body': 'I like XML better'},
      relationships: {'author': ToOne(Identifier.of(dan))},
      self: Link('http://example.com/comments/12'));

  final article = Resource(
    'articles',
    '1',
    self: Link('http://example.com/articles/1'),
    attributes: {'title': 'JSON API paints my bikeshed!'},
    relationships: {
      'author': ToOne(
        Identifier.of(dan),
        self: Link('http://example.com/articles/1/relationships/author'),
        related: Link('http://example.com/articles/1/author'),
      ),
      'comments': ToMany(
          [Identifier.of(firstComment), Identifier.of(secondComment)],
          self: Link('http://example.com/articles/1/relationships/comments'),
          related: Link('http://example.com/articles/1/comments'))
    },
  );

  return DataDocument.fromResourceList([article],
      self: Link('http://example.com/articles'),
      next: Link('http://example.com/articles?page[offset]=2'),
      last: Link('http://example.com/articles?page[offset]=10'),
      included: [dan, firstComment, secondComment]);
}

/// Print the JSON representation of the response to stdout
void main() {
  final response = makeJsonApiResponse();
  print(json.encode(response));
}
```

This code will produce the following output:
```json
{
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
}
```
