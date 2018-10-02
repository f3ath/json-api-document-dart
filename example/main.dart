import 'dart:convert';

import 'package:json_api_document/json_api_document.dart';

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

void main() {
  print(json.encode(doc));
}
