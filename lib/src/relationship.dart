import 'package:json_api_document/src/decoding_exception.dart';
import 'package:json_api_document/src/functions/decode_map.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/meta_property.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource_object.dart';
import 'package:json_api_document/src/to_many.dart';
import 'package:json_api_document/src/to_one.dart';

/// The Relationship represents the references between the resources.
///
/// A Relationship can be a JSON:API Document itself when
/// requested separately as described here https://jsonapi.org/format/#fetching-relationships.
///
/// It can also be a part of [ResourceObject].relationships map.
///
/// More on this: https://jsonapi.org/format/#document-resource-object-relationships
class Relationship extends PrimaryData with MetaProperty {
  final Link related;

  Relationship(
      {this.related,
      Link self,
      Iterable<ResourceObject> included,
      Map<String, Object> meta})
      : super(self: self, included: included) {
    this.meta.addAll(meta ?? {});
  }

  /// Decodes a JSON:API Document or the `relationship` member of a Resource object.
  static Relationship decodeJson(Object json) {
    if (json is Map) {
      if (json.containsKey('data')) {
        final data = json['data'];
        if (data == null || data is Map) {
          return ToOne.decodeJson(json);
        }
        if (data is List) {
          return ToMany.decodeJson(json);
        }
      } else {
        final links = decodeMap(json['links'], Link.decodeJson);
        return Relationship(self: links['self'], related: links['related']);
      }
    }
    throw DecodingException('Can not decode Relationship from $json');
  }

  Map<String, Link> toLinks() => {
        ...super.toLinks(),
        if (related != null) ...{'related': related}
      };

  /// Top-level JSON object
  Map<String, Object> toJson() {
    final json = super.toJson();
    final links = toLinks();
    if (links.isNotEmpty) json['links'] = links;
    if (meta.isNotEmpty) json['meta'] = meta;
    return json;
  }

  bool identifies(ResourceObject resourceObject) => false;
}
