import 'primary_data.dart';
import 'resource_identifier.dart';

class ResourceIdentifierList implements PrimaryData {
  final _json;

  ResourceIdentifierList(List<ResourceIdentifier> identifiers)
      : _json = new List.unmodifiable(identifiers);

  @override
  toJson() => _json;
}
