import 'naming.dart';

class ResourceIdentifier {
  final String type;
  final String id;

  ResourceIdentifier(String this.type, String this.id) {
    if (id == null || id.isEmpty) throw ArgumentError();
    (const Naming()).enforce(type);
  }

  toJson() => {'type': type, 'id': id};
}
