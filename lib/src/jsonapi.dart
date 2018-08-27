import 'dart:collection';

import 'package:json_api_document/json_api_document.dart';

class JsonApi {
  final meta;
  final String version;

  JsonApi(Naming naming, [String this.version = '1.0']) : meta = Meta(naming);

  UnmodifiableMapView toJson() {
    final Map<String, dynamic> json = {'version': version};
    if (meta.isNotEmpty) {
      json['meta'] = meta;
    }
    return Map.unmodifiable(json);
  }
}
