part of '../json_api_document.dart';

class MetaDocument<N extends Naming> extends Document {
  MetaDocument(Meta<N> meta, {Api<N> api, Link<N> self})
      : super(meta: meta, api: api, self: self) {
    if (meta == null) throw ArgumentError();
  }
}
