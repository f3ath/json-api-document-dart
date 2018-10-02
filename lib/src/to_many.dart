import 'identifier.dart';
import 'link.dart';
import 'relationship.dart';

class ToMany extends Relationship {
  ToMany(List<Identifier> data, {Link self, Link related})
      : super(data, self: self, related: related);
}
