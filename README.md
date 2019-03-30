Other JSON:API packages: [Client](https://pub.dartlang.org/packages/json_api) | [Server](https://pub.dartlang.org/packages/json_api_server)

---
# JSON:API Document
[JSON:API](http://jsonapi.org) is a specification for building APIs in JSON. This library implements 
the Document model and a Parser.

## Document model
The Document is a set of Dart classes describing the main JSON:API objects: Resources and Resource Identifiers, 
Primary Data, Relationships, etc. Use it to produce a valid JSON:API Document.

Put the following code to `hello_world.dart`:
```dart
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
```
Now execute: 
```bash
dart hello_world.dart
``` 

It will produce the following output (formatted for clarity):
```json
{
  "data": {
    "type":"messages",
    "id":"1",
    "attributes": {
      "text":"Hello world"
    }
  },
  "links": {
    "self":"/messages/1"
  }
}
```

## Parser
The Parser converts parsed JSON objects to Documents.

Put this code to `hello_world_parse.dart`:
```dart
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

  // Print the attributes
  doc.data.resourceObject.attributes.forEach((k, v) => print('$k: $v'));
}
```

Now let\'s run them together feeding the output of the first program to the second:
```bash
dart hello_world.dart | dart hello_world_parse.dart
```

This will output the parsed attributes:

```
text: Hello world

```

Please refer to the `example` and `test` folders for usage examples.
