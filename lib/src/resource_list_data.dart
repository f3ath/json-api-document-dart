import 'package:json_api_document/src/friendly_to_string.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class ResourceListData with FriendlyToString implements PrimaryData {
  final List<Resource> _resources;

  ResourceListData(this._resources);

  bool identifies(Resource another) =>
      _resources.any((res) => res.identifies(another));

  toJson() => _resources;

  List<Resource> get resources => List.from(_resources);
}
