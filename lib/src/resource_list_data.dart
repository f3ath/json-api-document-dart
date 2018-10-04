import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class ResourceListData implements PrimaryData {
  final List<Resource> _resources;

  ResourceListData(List<Resource> this._resources);

  @override
  bool identifies(Resource another) =>
      _resources.any((res) => res.identifies(another));

  @override
  toJson() => _resources;
}
