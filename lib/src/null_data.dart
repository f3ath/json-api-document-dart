import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class NullData implements PrimaryData {
  bool identifies(Resource resource) => false;

  toJson() => null;
}
