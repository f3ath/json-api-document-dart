import 'dart:collection';

import 'package:json_api_document/json_api_document.dart';

class Meta {
  final _meta = Map<String, dynamic>();
  final Naming _naming;

  Meta(Naming this._naming);

  operator [](String key) => _meta[key];

  void operator []=(String key, dynamic val) {
    if (!_naming.allows(key)) {
      throw ArgumentError();
    }
    _meta[key] = val;
  }

  bool get isEmpty => _meta.isEmpty;

  bool get isNotEmpty => _meta.isNotEmpty;

  UnmodifiableMapView toJson() => Map.unmodifiable(_meta);
}
