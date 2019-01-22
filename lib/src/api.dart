import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/src/friendly_to_string.dart';
import 'package:json_api_document/src/helpers.dart';

/// A JSON API Object.
///
/// See http://jsonapi.org/format/#document-jsonapi-object
class Api with FriendlyToString {
  final String version;
  final Meta meta;

  Api(this.version, {Map<String, dynamic> meta})
      : meta = nullOr(meta, (_) => Meta(_)) {
    if (version == null && meta == null) throw ArgumentError();
  }

  /// Returns the JSON representation.
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> j = {'version': version};
    if (meta != null) j['meta'] = meta;
    return j;
  }

  /// Creates an instance from [json]. If [json] is null, returns null.
  static Api fromJson(Map<String, dynamic> json) =>
      json == null ? null : Api(json['version'], meta: json['meta']);
}
