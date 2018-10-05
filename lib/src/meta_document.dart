import 'package:json_api_document/src/api.dart';
import 'package:json_api_document/src/document.dart';
import 'package:json_api_document/src/link.dart';

class MetaDocument extends Document {
  MetaDocument(Map<String, dynamic> meta, {Api api, Link self})
      : super(meta: meta, api: api, self: self) {
    if (meta == null) throw ArgumentError();
  }
}
