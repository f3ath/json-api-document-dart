import 'api.dart';
import 'link.dart';
import 'meta.dart';
import 'meta_document.dart';

abstract class Document {
  final Meta meta;
  final Api api;
  final Link self;
  final Link related;
  final Link next;
  final Link last;

  Document(
      {Map<String, dynamic> meta,
      Api this.api,
      Link this.next,
      Link this.last,
      Link this.self,
      Link this.related})
      : meta = Meta.fromMap(meta);

  toJson() {
    final j = Map<String, dynamic>();
    if (meta != null) j['meta'] = meta;
    if (api != null) j['jsonapi'] = api;
    final links = {'self': self, 'related': related, 'next': next, 'last': last}
      ..removeWhere((name, link) => link == null);

    if (links.isNotEmpty) j['links'] = links;
    return j;
  }

  static Document fromJson(Map<String, dynamic> json) {
    final links = json['links'];
    final self = links != null ? Link.fromJson(links['self']) : null;
    if (json.containsKey('meta')) {
      return MetaDocument(json['meta'],
          api: Api.fromJson(json['jsonapi']), self: self);
    }
    throw CastError();
  }
}
