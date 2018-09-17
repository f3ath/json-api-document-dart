import 'meta.dart';
import 'link.dart';
import 'jsonapi.dart';
import 'naming.dart';

class MetaDocument<N extends Naming> {
  final Meta meta;
  final JsonApi jsonapi;
  final Link self;

  MetaDocument(Meta<N> this.meta, {JsonApi<N> this.jsonapi, Link<N> this.self}) {
    if (meta == null) throw ArgumentError();
  }

  toJson() {
    final Map<String, dynamic> j = {'meta': meta};
    if (jsonapi != null) j['jsonapi'] = jsonapi;
    if (self != null) j['links'] = {'self': self};
    return j;
  }
}
