import 'package:json_api_document/src/document/friendly_to_string.dart';
import 'package:json_api_document/src/document/primary_data.dart';
import 'package:json_api_document/src/document/resource.dart';

class ResourceData  with FriendlyToString implements PrimaryData {
  final Resource _resource;

  ResourceData(Resource this._resource);

  Resource get resource => _resource;

  bool identifies(Resource another) => _resource.identifies(another);

  Map<String, dynamic> toJson() => _resource.toJson();

  List<Resource> get resources => [_resource];
}
