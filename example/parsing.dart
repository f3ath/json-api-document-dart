import 'dart:convert';
import 'dart:io';

import 'package:json_api_document/parser.dart';

void main() async {
  final parser = JsonApiParser();
  final jsonString = await stdin.transform(Utf8Decoder()).join();
  final jsonObject = json.decode(jsonString);
  final doc = parser.parseResourceCollectionDocument(jsonObject);
  final collection = doc.data.collection;
  final included = doc.data.included;
  print('The document contains ${collection.length} primary resource(s):');
  collection.forEach((_) => print(_.toResource()));
  print('The document contains ${included.length} included resource(s):');
  included.forEach((_) => print(_.toResource()));
}
