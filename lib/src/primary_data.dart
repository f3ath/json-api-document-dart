import 'package:json_api_document/src/friendly_to_string.dart';
import 'package:json_api_document/src/resource.dart';

abstract class PrimaryData with FriendlyToString {
  bool identifies(Resource resource);

  List<Resource> get resources;

  toJson();
}
