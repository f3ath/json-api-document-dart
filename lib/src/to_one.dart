import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/relationship.dart';
import 'package:json_api_document/src/resource.dart';

class ToOne extends Relationship {
  final Identifier data;

  ToOne(Identifier this.data, {Link self, Link related})
      : super(self: self, related: related);

  @override
  bool identifies(Resource resource) => data.identifies(resource);
}
