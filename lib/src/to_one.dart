import 'package:json_api_document/src/decoding_exception.dart';
import 'package:json_api_document/src/functions/decode_list.dart';
import 'package:json_api_document/src/functions/decode_map.dart';
import 'package:json_api_document/src/functions/nullable.dart';
import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/identifier_object.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/relationship.dart';
import 'package:json_api_document/src/resource_object.dart';

/// Relationship to-one
class ToOne extends Relationship {
  /// Resource Linkage
  ///
  /// Can be null for empty relationships
  ///
  /// More on this: https://jsonapi.org/format/#document-resource-object-linkage
  final IdentifierObject linkage;

  ToOne(this.linkage,
      {Link self,
      Link related,
      Iterable<ResourceObject> included,
      Map<String, Object> meta})
      : super(self: self, related: related, included: included, meta: meta);

  ToOne.empty({Link self, Link related, Map<String, Object> meta})
      : linkage = null,
        super(self: self, related: related, meta: meta);

  static ToOne fromIdentifier(Identifier identifier,
          {Map<String, Object> meta}) =>
      ToOne(nullable(IdentifierObject.fromIdentifier)(identifier), meta: meta);

  static ToOne decodeJson(Object json) {
    if (json is Map) {
      final links = decodeMap(json['links'], Link.decodeJson);
      if (json.containsKey('data')) {
        return ToOne(nullable(IdentifierObject.decodeJson)(json['data']),
            self: links['self'],
            related: links['related'],
            meta: json['meta'],
            included: decodeList(json['included'], ResourceObject.decodeJson));
      }
    }
    throw DecodingException('Can not decode ToOne from $json');
  }

  Map<String, Object> toJson() => super.toJson()..['data'] = linkage;

  /// Converts to [Identifier].
  /// For empty relationships return null.
  Identifier toIdentifier() => linkage?.toIdentifier();

  @override
  bool identifies(ResourceObject resourceObject) =>
      resourceObject.toResource().toIdentifier().equals(toIdentifier());
}
