import 'identifier.dart';
import 'link.dart';
import 'relationship.dart';

class ToOne extends Relationship {
  ToOne(Identifier data, {Link self, Link related})
      : super(data, self: self, related: related);
}
