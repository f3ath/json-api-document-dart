### Building stuff
[build.dart](example/build.dart) builds a new JSON API Document and prints its JSON representation.

Run
```
dart example/build.dart
```
to produce a sample JSON API Document. For your convenience, [document.json](example/document.json) already contains 
the pretty-printed version of this document.

### Parsing stuff
[parse.dart](example/parse.dart) parses any JSON API document from the standard input.

Run
```
dart example/parse.dart < example/document.json
```
to parse the example document. This will produce the following output:
```
This is DataDocument
The primary data is ResourceListData with 1 resource(s).
The document contains 3 included resource(s).

```