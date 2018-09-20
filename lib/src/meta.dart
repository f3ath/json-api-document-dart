part of '../json_api_document.dart';

class Meta<N extends Naming> {
  final Map<String, dynamic> _meta;

  Meta(Map<String, dynamic> meta) : _meta = Map.from(meta) {
    final naming = Naming.get(N);
    meta.keys.forEach(naming.enforce);
  }

  Meta._(Map<String, dynamic> this._meta);

  Meta<N> operator |(Meta<N> other) =>
      Meta(Map<String, dynamic>()..addAll(other._meta)..addAll(_meta));

  operator [](String key) => _meta[key];

  toJson() => Map.from(_meta);

  Meta<N> remove(String key) {
    return Meta._<N>(Map<String, dynamic>.from(_meta)..remove(key));
  }
}
