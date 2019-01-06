import 'package:json_api_document/src/document/resource.dart';

abstract class PrimaryData {
  bool identifies(Resource resource);

  List<Resource> get resources;

  toJson();
}
