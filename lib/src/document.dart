import 'api.dart';
import 'link.dart';
import 'meta.dart';

abstract class Document {
  final Meta meta;
  final Api api;
  final Link self;

  Document({Meta this.meta, Api this.api, Link this.self});

  toJson() {
    final j = Map<String, dynamic>();
    if (meta != null) j['meta'] = meta;
    if (api != null) j['jsonapi'] = api;
    if (self != null) j['links'] = {'self': self};
    return j;
  }
}
