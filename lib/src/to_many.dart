import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/relationship.dart';
import 'package:json_api_document/src/resource.dart';

class ToMany extends Relationship {
  final List<Identifier> data;

  ToMany(List<Identifier> data, {Link self, Link related})
      : data = List.unmodifiable(data),
        super(self: self, related: related);

  @override
  bool identifies(Resource resource) =>
      data.any((id) => id.identifies(resource));
}
