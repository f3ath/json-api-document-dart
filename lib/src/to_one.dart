import 'package:json_api_document/src/resource.dart';

import 'identifier.dart';
import 'link.dart';
import 'relationship.dart';

class ToOne extends Relationship {
  final Identifier data;

  ToOne(Identifier this.data, {Link self, Link related})
      : super(self: self, related: related);

  @override
  bool identifies(Resource resource) => data.identifies(resource);
}
