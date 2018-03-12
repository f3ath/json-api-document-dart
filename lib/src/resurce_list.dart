import 'primary_data.dart';
import 'resource.dart';

class ResourceList implements PrimaryData {
  final _json;

  ResourceList(List<Resource> resources)
      : _json = new List.unmodifiable(resources);

  @override
  toJson() => _json;
}
