import 'package:json_api_document/src/meta.dart';
import 'package:json_api_document/src/naming.dart';
import 'package:json_api_document/src/resource.dart';

/// A Resource Identifier object.
///
/// http://jsonapi.org/format/#document-resource-identifier-objects
class Identifier {
  final String type;
  final String id;
  final Meta meta;

  /// Both [type] and [id] must be non-empty strings.
  Identifier(this.type, this.id, {Map<String, dynamic> meta})
      : meta = Meta.orNull(meta) {
    if (id == null || id.isEmpty) throw ArgumentError();
    (const Naming()).enforce(type);
  }

  /// Returns Identifier of [resource]
  static Identifier of(Resource resource) =>
      Identifier(resource.type, resource.id);

  /// Returns the JSON representation.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {'type': type};
    json['id'] = id;
    if (meta != null) json['meta'] = meta;

    return json;
  }

  /// Returns true if [type] and [id] match those of [resource]
  identifies(Resource resource) => type == resource.type && id == resource.id;
}
