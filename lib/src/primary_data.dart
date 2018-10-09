import 'package:json_api_document/src/resource.dart';

abstract class PrimaryData {
  bool identifies(Resource resource);

  List<Resource> get resources;

  toJson();
}
