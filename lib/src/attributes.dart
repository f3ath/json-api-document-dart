import 'naming.dart';

class Attributes {
  final Map<String, dynamic> _data;

  Attributes(Map<String, dynamic> attributes) : _data = Map.from(attributes) {
    attributes.keys.forEach(_enforceNaming);
  }

  toJson() => Map.from(_data);

  void _enforceNaming(String attr) {
    const Naming().enforce(attr);
    if (['relationships', 'links'].contains(attr)) throw ArgumentError();
  }
}
