import 'package:json_api_document/src/document/primary_data.dart';
import 'package:json_api_document/src/document/resource.dart';

class NullData implements PrimaryData {
  bool identifies(Resource resource) => false;

  toJson() => null;

  List<Resource> get resources => [];
}
