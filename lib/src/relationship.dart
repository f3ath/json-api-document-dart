import 'link.dart';
import 'resource.dart';

abstract class Relationship {
  final Link self;
  final Link related;

  /// Resource linkage
  ///
  /// http://jsonapi.org/format/#document-resource-object-linkage
  get data;

  Relationship({Link this.self, Link this.related});

  toJson() {
    final j = Map<String, dynamic>();
    j['data'] = data;
    final links = Map<String, Link>();
    if (self != null) links['self'] = self;
    if (related != null) links['related'] = related;
    if (links.isNotEmpty) j['links'] = links;

    return j;
  }

  bool identifies(Resource resource);
}
