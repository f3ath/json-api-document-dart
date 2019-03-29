import 'dart:convert';
import 'dart:io';

import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../example/building.dart';

void main() {
  group('Example', () {
    test('Can produce the example document', () {
      final doc = createExampleDocument();
      final expected = File('test/example.json').readAsStringSync();
      expect(doc, encodesToJson(json.decode(expected)));
    }, testOn: 'vm');

    test('Hello world', () {
      final helloWorld =
          Resource('messages', '1', attributes: {'text': 'Hello world'});
      final resourceObj = ResourceObject.fromResource(helloWorld);
      final primaryData =
          ResourceData(resourceObj, self: Link(Uri.parse('/messages/1')));
      final doc = Document(primaryData);
      expect(
          doc,
          encodesToJson({
            "links": {"self": "/messages/1"},
            "data": {
              "type": "messages",
              "id": "1",
              "attributes": {"text": "Hello world"}
            }
          }));
    });
  });
}

helloWorld() {
  final message =
      ResourceObject('messages', '1', attributes: {'text': 'Hello world'});
  final primaryData =
      ResourceData(message, self: Link(Uri.parse('/messages/1')));
  final doc = Document(primaryData);
}
