import 'dart:convert';
import 'dart:io';

import 'package:json_api_document/parser.dart';

void main() async {
  // Read the json from the standard input
  final jsonString = await stdin.transform(Utf8Decoder()).join();

  // Convert the json to a Dart object
  final jsonObject = json.decode(jsonString);

  // Parse the object into a document
  final doc = JsonApiParser().parseResourceDocument(jsonObject);

  // Print all attributes
  doc.data.resourceObject.attributes.forEach((k, v) => print('$k: $v'));
}
