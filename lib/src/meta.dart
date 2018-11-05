import 'package:json_api_document/src/naming.dart';

/// A Meta information object.
///
/// http://jsonapi.org/format/#document-meta
class Meta {
  final Map<String, dynamic> _meta;

  Meta(Map<String, dynamic> meta) : _meta = Map.from(meta) {
    if (meta.isEmpty) throw ArgumentError('Empty meta');
    meta.keys.forEach(Naming().enforce);
  }

  /// Returns true if this meta contains the given [value].
  bool containsValue(Object value) => _meta.containsValue(value);

  /// Returns true if this meta contains the given [key].
  bool containsKey(String key) => _meta.containsKey(key);

  /// Returns the value for the given [key] or null if [key] is not in the meta.
  operator [](String key) => _meta[key];

  Iterable<MapEntry<String, dynamic>> get entries => _meta.entries;

  /// Parses [json] into [Meta]. Returns null if [json] is null.
  static Meta fromJson(Map<String, dynamic> json) =>
      json == null ? null : Meta(json);

  toJson() => Map.from(_meta);
}
