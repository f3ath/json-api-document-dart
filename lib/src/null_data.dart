import 'package:json_api_document/src/friendly_to_string.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class NullData with FriendlyToString implements PrimaryData {
  bool identifies(Resource resource) => false;

  toJson() => null;

  List<Resource> get resources => [];
}
