import 'naming.dart';

class Meta {
  final Map<String, dynamic> _meta;

  Meta(Map<String, dynamic> meta) : _meta = Map.from(meta) {
    if (meta.isEmpty) throw ArgumentError('Empty meta');
    meta.keys.forEach((const Naming()).enforce);
  }

  static Meta fromMap(Map<String, dynamic> map) =>
      map == null ? null : Meta(map);

  Meta._(Map<String, dynamic> this._meta);

  Meta operator |(Meta other) =>
      Meta(Map<String, dynamic>()..addAll(other._meta)..addAll(_meta));

  operator [](String key) => _meta[key];

  toJson() => Map.from(_meta);

  toMap() => Map.from(_meta);
}
