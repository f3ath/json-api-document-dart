import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/identifier_object.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/relationship.dart';
import 'package:json_api_document/src/resource.dart';

/// [ResourceObject] is a JSON representation of a [Resource].
///
/// It carries all JSON-related logic and the Meta-data.
/// In a JSON:API Document it can be the value of the `data` member (a `data`
/// member element in case of a collection) or a member of the `included`
/// resource collection.
///
/// More on this: https://jsonapi.org/format/#document-resource-objects
class ResourceObject {
  final String type;
  final String id;
  final Link self;
  final Map<String, Object> attributes;
  final Map<String, Relationship> relationships;
  final Map<String, String> meta;

  ResourceObject(this.type, this.id,
      {this.self,
      Map<String, Object> attributes,
      Map<String, Relationship> relationships,
      Map<String, String> meta})
      : meta = meta == null ? null : Map.from(meta),
        attributes = attributes == null ? null : Map.from(attributes),
        relationships = relationships == null ? null : Map.from(relationships);

  static ResourceObject fromResource(Resource resource,
      {Map<String, String> meta}) {
    final relationships = <String, Relationship>{}
      ..addAll(resource.toOne.map((k, v) => MapEntry(
          k, ToOne(v == null ? null : IdentifierObject.fromIdentifier(v)))))
      ..addAll(resource.toMany.map((k, v) =>
          MapEntry(k, ToMany(v.map(IdentifierObject.fromIdentifier)))));

    return ResourceObject(resource.type, resource.id,
        attributes: resource.attributes,
        relationships: relationships,
        meta: meta);
  }

  /// Returns the JSON object to be used in the `data` or `included` members
  /// of a JSON:API Document
  Map<String, Object> toJson() {
    final json = <String, Object>{'type': type};
    if (id != null) {
      json['id'] = id;
    }
    if (attributes?.isNotEmpty == true) {
      json['attributes'] = attributes;
    }
    if (relationships?.isNotEmpty == true) {
      json['relationships'] = relationships;
    }
    if (self != null) {
      json['links'] = {'self': self};
    }
    return json;
  }

  /// Converts to [Resource] if possible. The standard allows relationships
  /// without `data` member. In this case the original [Resource] can not be
  /// recovered and this method will throw a [StateError].
  ///
  /// TODO: we probably need `isIncomplete` flag to check for this.
  Resource toResource() {
    final toOne = <String, Identifier>{};
    final toMany = <String, List<Identifier>>{};
    final incomplete = <String, Relationship>{};
    (relationships ?? {}).forEach((name, rel) {
      if (rel is ToOne) {
        toOne[name] = rel.toIdentifier();
      } else if (rel is ToMany) {
        toMany[name] = rel.toIdentifiers().toList();
      } else {
        incomplete[name] = rel;
      }
    });

    if (incomplete.isNotEmpty) {
      throw StateError('Can not convert to resource'
          ' due to incomplete relationships data: ${incomplete.keys}');
    }

    return Resource(type, id,
        attributes: attributes, toOne: toOne, toMany: toMany);
  }

  /// Returns true if this resource object identifies the [other].
  /// For a ResourceObject "identifies" means contains an IdentifierObject
  /// pointing to the [other].
  bool identifies(ResourceObject other) =>
      relationships.values.any((_) => _.identifies(other));
}
