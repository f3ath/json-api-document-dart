import 'package:json_api_document/src/attributes.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/meta.dart';
import 'package:json_api_document/src/naming.dart';
import 'package:json_api_document/src/relationship.dart';
import 'package:json_api_document/src/relationships.dart';

class Resource {
  final String type;
  final String id;
  final Attributes attributes;
  final Link self;
  final Meta meta;
  final Relationships relationships;

  Resource(this.type, this.id,
      {Map<String, dynamic> attributes,
      this.self,
      Map<String, dynamic> meta,
      Map<String, Relationship> relationships})
      : meta = Meta.orNull(meta),
        attributes = Attributes.orNull(attributes),
        relationships = Relationships.orNull(relationships) {
    if (id != null && id.isEmpty) throw ArgumentError();
    final naming = const Naming();
    naming.enforce(type);
    if (relationships != null && attributes != null) {
      final fields = Set<String>.of(attributes.keys);
      final unique = relationships.keys.every(fields.add);
      if (!unique) throw ArgumentError();
    }
  }

  toJson() {
    final Map<String, dynamic> j = {'type': type};
    if (id != null) j['id'] = id;
    if (attributes != null) j['attributes'] = attributes;
    if (meta != null) j['meta'] = meta;
    if (self != null) j['links'] = {'self': self};
    if (relationships != null && relationships.isNotEmpty)
      j['relationships'] = relationships;

    return j;
  }

  bool identifies(Resource resource) =>
      relationships != null &&
      relationships.values.any((rel) => rel.identifies(resource));

  static Resource fromJson(Map<String, dynamic> json) {
    Link self;
    final links = json['links'];
    if (links is Map) {
      if (links['self'] != null) self = Link.fromJson(links['self']);
    }

    return Resource(json['type'], json['id'],
        attributes: json['attributes'],
        self: self,
        meta: json['meta'],
        relationships: json['relationships'] == null
            ? null
            : Map.fromEntries(
                Relationships.fromJson(json['relationships']).entries));
  }
}
