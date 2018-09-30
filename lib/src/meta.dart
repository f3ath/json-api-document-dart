import 'naming.dart';

class Meta {
  final Map<String, dynamic> _meta;

  Meta(Map<String, dynamic> meta) : _meta = Map.from(meta) {
    meta.keys.forEach((const Naming()).enforce);
  }

  Meta._(Map<String, dynamic> this._meta);

  Meta operator |(Meta other) =>
      Meta(Map<String, dynamic>()..addAll(other._meta)..addAll(_meta));

  operator [](String key) => _meta[key];

  toJson() => Map.from(_meta);

  Meta remove(String key) {
    return Meta._(Map<String, dynamic>.from(_meta)..remove(key));
  }
}
