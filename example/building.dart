import 'dart:convert';

import 'package:json_api_document/json_api_document.dart';

/// Print the JSON representation of the response to stdout
void main() {
  final response = createExampleDocument();
  print(json.encode(response));
}

Document createExampleDocument() {
  final url = UrlBuilder('http://example.com');

  final dan = Resource('people', '9', attributes: {
    'firstName': 'Dan',
    'lastName': 'Gebhardt',
    'twitter': 'dgeb'
  });

  final comments = [
    Resource('comments', '5',
        attributes: {'body': 'First!'},
        toOne: {'author': Identifier('people', '2')}),
    Resource('comments', '12',
        attributes: {'body': 'I like XML better'},
        toOne: {'author': dan.toIdentifier()})
  ];

  final article = Resource('articles', '1',
      attributes: {'title': 'JSON:API paints my bikeshed!'},
      toOne: {'author': dan.toIdentifier()},
      toMany: {'comments': comments.map((_) => _.toIdentifier()).toList()});

  final articleJson = ResourceObject(article.type, article.id,
      attributes: article.attributes,
      self: Link(url.resource(article.type, article.id)),
      relationships: {
        'author': ToOne(IdentifierObject(dan.type, dan.id),
            self: Link(url.relationship('articles', '1', 'author')),
            related: Link(url.related('articles', '1', 'author'))),
        'comments': ToMany(
            comments
                .map((_) => _.toIdentifier())
                .map(IdentifierObject.fromIdentifier),
            self: Link(url.relationship('articles', '1', 'comments')),
            related: Link(url.related('articles', '1', 'comments'))),
      });

  final pagination = Pagination(
      next: Link(
          url.collection('articles').replace(queryParameters: {'page': '2'})),
      last: Link(
          url.collection('articles').replace(queryParameters: {'page': '10'})));

  final collection = ResourceCollectionData([articleJson],
      pagination: pagination,
      self: Link(url.collection('articles')),
      included: [
            ResourceObject(dan.type, dan.id,
                attributes: dan.attributes,
                self: Link(url.resource('people', dan.id)))
          ] +
          comments
              .map((_) => ResourceObject(_.type, _.id,
                  attributes: _.attributes,
                  relationships: {
                    'author': ToOne(
                        IdentifierObject.fromIdentifier(_.toOne['author']))
                  },
                  self: Link(url.resource('comments', _.id))))
              .toList());

  return Document(collection);
}

class UrlBuilder {
  final Uri base;

  UrlBuilder(String base) : base = Uri.parse(base);

  Uri collection(String type) => _uri([type]);

  Uri related(String type, String id, String relationship) =>
      _uri([type, id, relationship]);

  Uri relationship(String type, String id, String relationship) =>
      _uri([type, id, 'relationships', relationship]);

  Uri resource(String type, String id) => _uri([type, id]);

  Uri _uri(List<String> segments) =>
      base.replace(pathSegments: base.pathSegments + segments);
}
