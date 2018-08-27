import 'dart:collection';

import 'package:json_api_document/json_api_document.dart';

class Document {
  final Naming naming;
  final Meta meta;
  final JsonApi jsonapi;

  Document({Naming this.naming = const StrictNaming()})
      : meta = Meta(naming),
        jsonapi = JsonApi(naming) {}

  bool get isValid => meta.isNotEmpty;

  UnmodifiableMapView toJson() {
    if (meta.isEmpty) {
      throw StateError('Document is invalid');
    }
    return Map.unmodifiable({'meta': meta, 'jsonapi': jsonapi});
  }
}
