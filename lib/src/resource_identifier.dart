import 'primary_data.dart';

class ResourceIdentifier implements PrimaryData {
  final Map<String, dynamic> json;

  ResourceIdentifier(String type, String id)
      : json = new Map.unmodifiable({'type': type, 'id': id});
}
