import 'primary_data.dart';

class Resource implements PrimaryData {
  Map<String, dynamic> _json;

  Resource(String type, String id, {Map<String, dynamic> attributes})
      : _json = {'type': type, 'id': id} {
    if (attributes != null && attributes.isNotEmpty) {
      _json['attributes'] = new Map.unmodifiable(attributes);
    }
    _json = new Map.unmodifiable(_json);
  }

  toJson() => _json;
}
