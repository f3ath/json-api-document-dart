import 'naming.dart';

class Attributes {
  final Map<String, dynamic> _data;

  Attributes(Map<String, dynamic> attributes) : _data = Map.from(attributes) {
    attributes.keys.forEach(_enforceNaming);
  }

  static fromMap(Map<String, dynamic> attributes) =>
      attributes == null ? null : Attributes(attributes);

  toJson() => Map.from(_data);

  void _enforceNaming(String attr) {
    const Naming().enforce(attr);
    if (['relationships', 'links', 'type', 'id'].contains(attr)) throw ArgumentError();
  }
}
