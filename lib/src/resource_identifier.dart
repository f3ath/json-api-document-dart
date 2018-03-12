import 'primary_data.dart';
import 'utils.dart';

class ResourceIdentifier implements PrimaryData {
  final Map<String, dynamic> _json;

  ResourceIdentifier(String type, String id)
      : _json = new Map.unmodifiable({'type': type, 'id': id}) {
    if (isInvalidMember(type)) {
      throw new ArgumentError('Invalid type: $type');
    }
  }

  toJson() => _json;
}
