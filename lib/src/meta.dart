import 'package:json_api_document/json_api_document.dart';


class Meta {
  final Naming naming;
  final _meta = Map<String, dynamic>();

  Meta(Naming this.naming, Map<String, dynamic> meta) {
    setAll(meta);
  }

  operator [](String key) => _meta[key];

  void operator []=(String key, dynamic val) {
    if (!naming.allows(key)) {
      throw ArgumentError('Member name "$key" is not allowed by naming rules');
    }
    _meta[key] = val;
  }

  bool get isEmpty => _meta.isEmpty;

  bool get isNotEmpty => _meta.isNotEmpty;

  toJson() => Map.unmodifiable(_meta);

  void remove(String key) {
    _meta.remove(key);
    if (_meta.isEmpty) throw StateError('Meta object can not be empty');
  }

  void replaceWith(Map<String, dynamic> other) {
    if (other.isEmpty) throw ArgumentError();
    _meta.clear();
    setAll(other);
  }

  void setAll(Map<String, dynamic> other) {
    other.forEach((k, v) => this[k] = v);
  }
}
