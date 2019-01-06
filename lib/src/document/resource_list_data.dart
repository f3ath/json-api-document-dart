import 'package:json_api_document/src/document/primary_data.dart';
import 'package:json_api_document/src/document/resource.dart';

class ResourceListData implements PrimaryData {
  final List<Resource> _resources;

  ResourceListData(this._resources);

  bool identifies(Resource another) =>
      _resources.any((res) => res.identifies(another));

  toJson() => _resources;

  List<Resource> get resources => List.from(_resources);
}
