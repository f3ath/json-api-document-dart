import 'naming.dart';

class Identifier {
  final String type;
  final String id;

  Identifier(String this.type, String this.id) {
    if (id == null || id.isEmpty) throw ArgumentError();
    (const Naming()).enforce(type);
  }

  toJson() => {'type': type, 'id': id};
}
