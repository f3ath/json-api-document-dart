import 'primary_data.dart';
import 'resource.dart';

class NullData implements PrimaryData {
  bool identifies(Resource resource) => false;

  toJson() => null;
}
