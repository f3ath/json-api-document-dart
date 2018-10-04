import 'identifier.dart';
import 'link.dart';
import 'relationship.dart';
import 'resource.dart';

class ToMany extends Relationship {
  final List<Identifier> data;

  ToMany(List<Identifier> data, {Link self, Link related})
      : data = List.unmodifiable(data),
        super(self: self, related: related);

  @override
  bool identifies(Resource resource) => data.any(resource.isIdentifiedBy);
}
