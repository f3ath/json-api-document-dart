import 'meta.dart';
import 'link.dart';
import 'api.dart';
import 'naming.dart';

class MetaDocument<N extends Naming> {
  final Meta meta;
  final Api api;
  final Link self;

  MetaDocument(Meta<N> this.meta, {Api<N> this.api, Link<N> this.self}) {
    if (meta == null) throw ArgumentError();
  }

  toJson() {
    final Map<String, dynamic> j = {'meta': meta};
    if (api != null) j['jsonapi'] = api;
    if (self != null) j['links'] = {'self': self};
    return j;
  }
}
