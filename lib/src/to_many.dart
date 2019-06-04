import 'package:json_api_document/src/decoding_exception.dart';
import 'package:json_api_document/src/functions/decode_map.dart';
import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/identifier_object.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/pagination.dart';
import 'package:json_api_document/src/relationship.dart';
import 'package:json_api_document/src/resource_object.dart';

/// Relationship to-many
class ToMany extends Relationship {
  /// Resource Linkage
  ///
  /// Can be empty for empty relationships
  ///
  /// More on this: https://jsonapi.org/format/#document-resource-object-linkage
  final linkage = <IdentifierObject>[];

  final Pagination pagination;

  ToMany(Iterable<IdentifierObject> linkage,
      {Link self,
      Link related,
      Iterable<ResourceObject> included,
      Map<String, Object> meta,
      this.pagination = const Pagination.empty()})
      : super(self: self, related: related, included: included, meta: meta) {
    this.linkage.addAll(linkage);
  }

  static ToMany decodeJson(Object json) {
    if (json is Map) {
      final links = decodeMap(json['links'], Link.decodeJson);

      if (json.containsKey('data')) {
        final data = json['data'];
        if (data is List) {
          return ToMany(
            data.map(IdentifierObject.decodeJson),
            self: links['self'],
            related: links['related'],
            meta: json['meta'],
            pagination: Pagination.fromLinks(links),
          );
        }
      }
    }
    throw DecodingException('Can not decode ToMany from $json');
  }

  Map<String, Link> toLinks() => super.toLinks()..addAll(pagination.toLinks());

  Map<String, Object> toJson() => super.toJson()..['data'] = linkage;

  /// Converts to List<[Identifier]>.
  /// For empty relationships returns an empty List.
  List<Identifier> toIdentifiers() =>
      linkage.map((_) => _.toIdentifier()).toList();

  @override
  bool identifies(ResourceObject resourceObject) =>
      toIdentifiers().any(resourceObject.toResource().toIdentifier().equals);
}
