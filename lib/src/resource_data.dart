import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class ResourceData implements PrimaryData {
  final Resource _resource;

  ResourceData(Resource this._resource);

  Resource get resource => _resource;

  bool identifies(Resource another) => _resource.identifies(another);

  toJson() => _resource.toJson();

  List<Resource> get resources => [_resource];
}
