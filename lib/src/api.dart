import 'package:json_api_document/json_api_document.dart';

/// A JSON API Object.
///
/// See http://jsonapi.org/format/#document-jsonapi-object
class Api {
  final String version;
  final Meta meta;

  Api(String this.version, {Map<String, dynamic> meta})
      : meta = Meta.fromJson(meta) {
    if (version == null && meta == null) throw ArgumentError();
  }

  /// Returns the JSON representation.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> j = {'version': version};
    if (meta != null) j['meta'] = meta;
    return j;
  }

  /// Creates an instance from [json].
  static Api fromJson(Map<String, dynamic> json) =>
      Api(json['version'], meta: json['meta']);
}
