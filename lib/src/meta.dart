import 'package:json_api_document/src/naming.dart';

/// A Meta information object.
///
/// http://jsonapi.org/format/#document-meta
class Meta {
  final Map<String, dynamic> _meta;

  Meta(Map<String, dynamic> meta) : _meta = Map.from(meta) {
    if (meta.isEmpty) throw ArgumentError('Empty meta');
    meta.keys.forEach((const Naming()).enforce);
  }

  static Meta fromJson(Map<String, dynamic> json) =>
      json == null ? null : Meta(json);

  toJson() => Map.from(_meta);
}
