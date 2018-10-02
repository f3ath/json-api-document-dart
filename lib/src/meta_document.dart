import 'api.dart';
import 'document.dart';
import 'link.dart';

class MetaDocument extends Document {
  MetaDocument(Map<String, dynamic> meta, {Api api, Link self})
      : super(meta: meta, api: api, self: self) {
    if (meta == null) throw ArgumentError();
  }
}
