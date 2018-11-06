import 'dart:convert';
import 'dart:io';

import 'package:json_api_document/json_api_document.dart';

void main() async {
  final jsonString = await stdin.transform(Utf8Decoder()).join();
  final jsonObject = json.decode(jsonString);
  final doc = Document.fromJson(jsonObject);
  print('This is ${doc.runtimeType}');
  if (doc is DataDocument) {
    print('The primary data is ${doc.data.runtimeType} ' +
        'with ${doc.data.resources.length} resource(s).');
    print('The document contains ${doc.included.length} included resource(s).');
  }
}
