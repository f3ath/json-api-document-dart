import 'abstract_identifier.dart';
import 'identifier.dart';
import 'link.dart';
import 'resource.dart';

abstract class Relationship implements AbstractIdentifier {
  final data;
  final Link self;
  final Link related;

  Relationship(this.data, {Link this.self, Link this.related});

  toJson() {
    final j = Map<String, dynamic>();
    j['data'] = data;
    final links = Map<String, Link>();
    if (self != null) links['self'] = self;
    if (related != null) links['related'] = related;
    if (links.isNotEmpty) j['links'] = links;

    return j;
  }

  bool identifies(Resource resource) {
    if (data is Identifier) {
      return data.identifies(resource);
    } else {
      return data.any((Identifier id) => id.identifies(resource));
    }
  }
}
