import 'naming.dart';

class Resource {
  final String type;
  final String id;

  Resource(String this.type, String this.id, {Map<String, dynamic> attributes}) {
    if (id != null && id.isEmpty) throw ArgumentError();
    (const Naming()).enforce(type);
  }

  toJson() {
    final Map<String, dynamic> j = {'type': type};
    if (id != null) j['id'] = id;
    return j;
  }
}
