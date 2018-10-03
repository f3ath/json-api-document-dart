import 'naming.dart';
import 'resource.dart';

/// A Resource Identifier object.
///
/// http://jsonapi.org/format/#document-resource-identifier-objects
class Identifier {
  final String type;
  final String id;

  /// Both [type] and [id] must be non-empty strings.
  Identifier(String this.type, String this.id) {
    if (id == null || id.isEmpty) throw ArgumentError();
    (const Naming()).enforce(type);
  }

  /// Returns Identifier of [resource]
  static Identifier of(Resource resource) =>
      Identifier(resource.type, resource.id);

  /// Returns the JSON representation.
  Map<String, String> toJson() => {'type': type, 'id': id};
}
