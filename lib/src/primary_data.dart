import 'resource.dart';

abstract class PrimaryData {
  bool identifies(Resource resource);

  toJson();
}
