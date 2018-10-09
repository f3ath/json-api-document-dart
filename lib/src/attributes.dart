import 'package:json_api_document/src/naming.dart';

/// A Resource Attributes object
///
/// http://jsonapi.org/format/#document-resource-object-attributes
class Attributes {
  static const prohibited = const ['relationships', 'links', 'type', 'id'];
  final Map<String, dynamic> _data;

  Attributes(Map<String, dynamic> attributes) : _data = Map.from(attributes) {
    attributes.keys.forEach(_enforceNaming);
  }

  /// Creates an instance from [json]. If [json] is null, returns null.
  static Attributes fromJson(Map<String, dynamic> json) =>
      json == null ? null : Attributes(json);

  /// Returns the JSON representation.
  Map<String, dynamic> toJson() => Map.from(_data);

  void _enforceNaming(String attr) {
    const Naming().enforce(attr);
    if (prohibited.contains(attr)) throw ArgumentError();
  }
}
