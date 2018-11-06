import 'dart:convert';

import 'package:json_api_document/json_api_document.dart';

/// The following function produces the example document
/// from the first page of http://jsonapi.org/.
Document makeDocument() {
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
void main() => print(json.encode(makeDocument()));
