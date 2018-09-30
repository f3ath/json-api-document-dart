import 'api.dart';
import 'document.dart';
import 'link.dart';
import 'meta.dart';

class MetaDocument extends Document {
  MetaDocument(Meta meta, {Api api, Link self})
      : super(meta: meta, api: api, self: self) {
    if (meta == null) throw ArgumentError();
  }
}
