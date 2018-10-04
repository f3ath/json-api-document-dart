import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class ResourceData implements PrimaryData {
  final Resource _resource;
  ResourceData(Resource this._resource);

  @override
  bool identifies(Resource another) => _resource.identifies(another);

  @override
  toJson() => _resource.toJson();
}