import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/resource.dart';
import 'package:json_api_document/src/to_many.dart';
import 'package:json_api_document/src/to_one.dart';

abstract class Relationship {
  final Link self;
  final Link related;

  /// Resource linkage
  ///
  /// http://jsonapi.org/format/#document-resource-object-linkage
  get data;

  Relationship({Link this.self, Link this.related});

  toJson() {
    final Map<String, dynamic> j = {'data': data};
    final links = Map<String, Link>();
    if (self != null) links['self'] = self;
    if (related != null) links['related'] = related;
    if (links.isNotEmpty) j['links'] = links;

    return j;
  }

  bool identifies(Resource resource);

  static Relationship fromJson(json) {
    if (json is! Map) {
      throw FormatException('Failed to parse a Relationship.', json);
    }
    if (json['data'] is List) return ToMany.fromJson(json);
    return ToOne.fromJson(json);
  }
}
