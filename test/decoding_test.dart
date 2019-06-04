import 'dart:convert';
import 'dart:io';

import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/parser.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import 'helper/recode_json.dart';

void main() {
  final parser = JsonApiParser();
  group('Parser', () {
    test('Can parse the example document', () {
      // This is a slightly modified example from the JSON:API site
      // See: https://jsonapi.org/
      final jsonString = new File('test/example.json').readAsStringSync();
      final jsonObject = json.decode(jsonString);
      final doc =
          parser.parseDocument(jsonObject, parser.parseResourceCollectionData);

      expect(doc, encodesToJson(jsonObject));
    }, testOn: 'vm');

    test('Can parse a primary resource with missing id', () {
      final doc = parser.parseResourceDocument(recodeJson({
        'data': {'type': 'apples'}
      }));
      expect(doc.data.toResource().type, 'apples');
      expect(doc.data.toResource().id, isNull);
    });

    test('Can parse a primary resource with null id', () {
      final doc = parser.parseResourceDocument(recodeJson({
        'data': {'type': 'apples', 'id': null}
      }));
      expect(doc.data.toResource().type, 'apples');
      expect(doc.data.toResource().id, isNull);
    });

  });
}
