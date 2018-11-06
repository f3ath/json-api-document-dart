import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../example/main.dart';

void main() {
  test('Can build the example from http://jsonapi.org/', () {
    final response = makeJsonApiResponse();
    final json = {
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
                "self": "http://example.com/articles/1/relationships/author",
                "related": "http://example.com/articles/1/author"
              },
              "data": {"type": "people", "id": "9"}
            },
            "comments": {
              "links": {
                "self": "http://example.com/articles/1/relationships/comments",
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
    };
    expect(response, encodesToJson(json));
    expect(Document.fromJson(json), encodesToJson(json));
  });
}
