import 'package:json_api_document/src/resource.dart';

/// Resource identifier
///
/// Together with [Resource] forms the core of the Document model.
/// Identifiers are passed between the server and the client in the form
/// of [IdentifierObject]s.
class Identifier {
  /// Resource type
  final String type;

  /// Resource id
  final String id;

  /// Neither [type] nor [id] can be null or empty.
  Identifier(this.type, this.id) {
    ArgumentError.checkNotNull(type, 'type');
    ArgumentError.checkNotNull(id, 'id');
    if (type.isEmpty) throw ArgumentError.value(type, 'type');
    if (id.isEmpty) throw ArgumentError.value(id, 'id');
  }

  /// Returns true if the two identifiers have the same [type] and [id]
  bool equals(Identifier identifier) =>
      identifier != null && identifier.type == type && identifier.id == id;

  String toString() => "Identifier($type:$id)";
}
