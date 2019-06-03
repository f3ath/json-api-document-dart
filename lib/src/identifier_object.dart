import 'package:json_api_document/src/decoding_exception.dart';
import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/meta_property.dart';

/// [IdentifierObject] is a JSON representation of the [Identifier].
/// It carries all JSON-related logic and the Meta-data.
class IdentifierObject with MetaProperty {
  final String type;
  final String id;

  IdentifierObject(this.type, this.id, {Map<String, Object> meta}) {
    this.meta.addAll(meta ?? {});
  }

  static IdentifierObject fromIdentifier(Identifier id) =>
      IdentifierObject(id.type, id.id);

  static IdentifierObject decodeJson(Object json) {
    if (json is Map) {
      return IdentifierObject(json['type'], json['id'], meta: json['meta']);
    }
    throw DecodingException('Can not decode IdentifierObject from $json');
  }

  Identifier toIdentifier() => Identifier(type, id);

  Map<String, Object> toJson() => {
        'type': type,
        'id': id,
        if (meta.isNotEmpty) ...{'meta': meta},
      };
}
