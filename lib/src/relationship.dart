import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/identifier_object.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/pagination.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource_object.dart';

/// The Relationship represents the references between the resources.
///
/// A Relationship can be a JSON:API Document itself when
/// requested separately as described here https://jsonapi.org/format/#fetching-relationships.
///
/// It can also be a part of [ResourceObject].relationships map.
///
/// More on this: https://jsonapi.org/format/#document-resource-object-relationships
class Relationship extends PrimaryData {
  final Link related;

  Relationship({this.related, Link self, Iterable<ResourceObject> included})
      : super(self: self, included: included);

  Map<String, Link> toLinks() => related == null
      ? super.toLinks()
      : (super.toLinks()..['related'] = related);

  /// Top-level JSON object
  Map<String, Object> toJson() {
    final json = super.toJson();
    final links = toLinks();
    if (links.isNotEmpty) json['links'] = links;
    return json;
  }

  bool identifies(ResourceObject resourceObject) => false;
}

/// Relationship to-one
class ToOne extends Relationship {
  /// Resource Linkage
  ///
  /// Can be null for empty relationships
  ///
  /// More on this: https://jsonapi.org/format/#document-resource-object-linkage
  final IdentifierObject linkage;

  ToOne(this.linkage,
      {Link self, Link related, Iterable<ResourceObject> included})
      : super(self: self, related: related, included: included);

  ToOne.empty({Link self, Link related})
      : linkage = null,
        super(self: self, related: related);

  Map<String, Object> toJson() => super.toJson()..['data'] = linkage;

  /// Converts to [Identifier].
  /// For empty relationships return null.
  Identifier toIdentifier() => linkage?.toIdentifier();

  @override
  bool identifies(ResourceObject resourceObject) =>
      resourceObject.toResource().toIdentifier().equals(toIdentifier());
}

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
      this.pagination = const Pagination.empty()})
      : super(self: self, related: related, included: included) {
    this.linkage.addAll(linkage);
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
