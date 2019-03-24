import 'dart:convert';
import 'dart:io';

import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../example/json_api_document.dart';

void main() {
  group('Document', () {
    group('JSON Conversion', () {
      test('Can produce the example document', () {
        final doc = createExampleDocument();
        final expected = File('test/example.json').readAsStringSync();
        expect(doc, encodesToJson(json.decode(expected)));
      });
    });
  });
}
