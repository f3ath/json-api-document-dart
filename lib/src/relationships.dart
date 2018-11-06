import 'package:json_api_document/src/naming.dart';
import 'package:json_api_document/src/readonly_map.dart';
import 'package:json_api_document/src/relationship.dart';

class Relationships extends ReadonlyMap<String, Relationship> {
  Relationships(Map<String, Relationship> relationships)
      : super(relationships) {
    keys.forEach(Naming().enforce);
    if (keys.any(['type', 'id'].contains)) throw ArgumentError();
  }

  static Relationships orNull(Map<String, Relationship> relationships) =>
      relationships == null ? null : Relationships(relationships);

  static Relationships fromJson(Map<String, dynamic> json) {
    return Relationships(
        Map.fromIterables(json.keys, json.values.map(Relationship.fromJson)));
  }
}
