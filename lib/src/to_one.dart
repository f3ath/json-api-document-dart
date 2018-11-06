import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/relationship.dart';
import 'package:json_api_document/src/resource.dart';

class ToOne extends Relationship {
  final Identifier data;

  ToOne(this.data, {Link self, Link related})
      : super(self: self, related: related);

  @override
  bool identifies(Resource resource) => data.identifies(resource);

  static ToOne fromJson(Map<String, dynamic> json) {
    Link self, related;
    final links = json['links'];
    if (links is Map) {
      if (links['self'] != null) self = Link.fromJson(links['self']);
      if (links['related'] != null) related = Link.fromJson(links['related']);
    }

    final data = json['data'];
    if (data is Map<String, dynamic>) {
      return ToOne(Identifier.fromJson(data), self: self, related: related);
    }
    if (data == null) return ToOne(null, self: self, related: related);
    throw FormatException('Failed to parse Relationship.', json);
  }
}
