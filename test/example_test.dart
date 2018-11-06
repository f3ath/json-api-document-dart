import 'dart:convert';
import 'dart:io';

import 'package:json_api_document/json_api_document.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

import '../example/build.dart';

void main() {
  @Tags(['vm-only'])
  test('Can build the example from http://jsonapi.org/', () {
    final response = makeDocument();
    final jsonString = File('example/document.json').readAsStringSync();
    final jsonObject = json.decode(jsonString);
    expect(response, encodesToJson(jsonObject));
    expect(Document.fromJson(jsonObject), encodesToJson(jsonObject));
  });
}
