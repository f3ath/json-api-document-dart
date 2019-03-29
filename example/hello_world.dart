import 'dart:convert';

import 'package:json_api_document/json_api_document.dart';

main() {
  final message =
      ResourceObject('messages', '1', attributes: {'text': 'Hello world'});
  final primaryData =
      ResourceData(message, self: Link(Uri.parse('/messages/1')));

  final doc = Document(primaryData);

  print(json.encode(doc));
}
