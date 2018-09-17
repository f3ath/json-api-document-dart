import 'package:json_api_document/json_api_document.dart';

class Meta<N extends Naming> {
  final Map<String, dynamic> _meta;

  Meta(Map<String, dynamic> meta) : _meta = Map.from(meta) {
    if (meta.isEmpty) throw ArgumentError();
    final naming = Naming.get(N);
    meta.keys.forEach(naming.enforce);
  }

  Meta._(Map<String, dynamic> this._meta);

  Meta<N> operator |(Meta<N> other) =>
      Meta(Map<String, dynamic>()..addAll(other._meta)..addAll(_meta));

  operator [](String key) => _meta[key];

  toJson() => Map.from(_meta);

  Meta<N> remove(String key) {
    final copy = Map<String, dynamic>.from(_meta);
    copy.remove(key);
    if (copy.length == 0) throw StateError('Can not remove last element');
    return Meta._<N>(copy);
  }
}
