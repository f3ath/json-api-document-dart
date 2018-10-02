import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/meta.dart';

import 'attributes.dart';
import 'naming.dart';

class Resource {
  final String type;
  final String id;
  final Attributes attributes;
  final Link self;
  final Meta meta;

  Resource(String this.type, String this.id,
      {Attributes this.attributes, Link this.self, Map<String, dynamic> meta})
      : meta = Meta.fromMap(meta) {
    if (id != null && id.isEmpty) throw ArgumentError();
    (const Naming()).enforce(type);
  }

  toJson() {
    final Map<String, dynamic> j = {'type': type};
    if (id != null) j['id'] = id;
    if (attributes != null) j['attributes'] = attributes;
    if (meta != null) j['meta'] = meta;
    if (self != null) j['links'] = {'self': self};
    return j;
  }
}
