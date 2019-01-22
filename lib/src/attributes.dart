import 'package:json_api_document/src/friendly_to_string.dart';
import 'package:json_api_document/src/naming.dart';
import 'package:json_api_document/src/readonly_map.dart';

/// A Resource Attributes object
///
/// http://jsonapi.org/format/#document-resource-object-attributes
class Attributes extends ReadonlyMap<String, dynamic> with FriendlyToString {
  static const prohibited = const ['relationships', 'links', 'type', 'id'];

  /// Creates an instance from a map
  Attributes(Map<String, dynamic> attributes) : super(attributes) {
    keys.forEach(Naming().enforce);
    if (keys.any(prohibited.contains)) throw ArgumentError();
  }
}
