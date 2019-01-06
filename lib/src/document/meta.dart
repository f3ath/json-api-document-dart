import 'package:json_api_document/src/document/friendly_to_string.dart';
import 'package:json_api_document/src/document/naming.dart';
import 'package:json_api_document/src/document/readonly_map.dart';

/// A Meta information object.
///
/// http://jsonapi.org/format/#document-meta
class Meta extends ReadonlyMap<String, dynamic> with FriendlyToString {
  Meta(Map<String, dynamic> meta) : super(meta) {
    if (isEmpty) throw ArgumentError('Empty meta');
    keys.forEach(Naming().enforce);
  }

  /// Returns an instance of [Meta] or null.
  static Meta orNull(Map<String, dynamic> meta) =>
      meta == null ? null : Meta(meta);
}
