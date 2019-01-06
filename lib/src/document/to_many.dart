import 'package:json_api_document/src/document/identifier.dart';
import 'package:json_api_document/src/document/link.dart';
import 'package:json_api_document/src/document/relationship.dart';
import 'package:json_api_document/src/document/resource.dart';

class ToMany extends Relationship {
  final List<Identifier> data;

  ToMany(List<Identifier> data, {Link self, Link related})
      : data = List.unmodifiable(data),
        super(self: self, related: related);

  @override
  bool identifies(Resource resource) =>
      data.any((id) => id.identifies(resource));

  static ToMany fromJson(Map<String, dynamic> json) {
    Link self, related;
    final links = json['links'];
    if (links is Map) {
      if (links['self'] != null) self = Link.fromJson(links['self']);
      if (links['related'] != null) related = Link.fromJson(links['related']);
    }

    final data = json['data'];
    if (data is List) {
      return ToMany(data.map(Identifier.fromJson).toList(),
          self: self, related: related);
    }
    if (data is List && data.isEmpty) {
      return ToMany([], self: self, related: related);
    }
    throw FormatException('Failed to parse a ToMany Relationship.', json);
  }
}
