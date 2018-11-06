import 'package:json_api_document/src/naming.dart';
import 'package:json_api_document/src/readonly_map.dart';

/// A Resource Attributes object
///
/// http://jsonapi.org/format/#document-resource-object-attributes
class Attributes extends ReadonlyMap<String, dynamic> {
  static const prohibited = const ['relationships', 'links', 'type', 'id'];

  /// Creates an instance from a map
  Attributes(Map<String, dynamic> attributes) : super(attributes) {
    keys.forEach(Naming().enforce);
    if (keys.any(prohibited.contains)) throw ArgumentError();
  }

  /// Creates an instance of [Attributes] or null.
  static Attributes orNull(Map<String, dynamic> json) =>
      json == null ? null : Attributes(json);
}
