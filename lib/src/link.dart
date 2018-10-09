import 'package:json_api_document/src/meta.dart';

/// A Link.
///
/// http://jsonapi.org/format/#document-links
class Link {
  final String url;
  final bool isObject = false;
  final Meta meta = null;

  Link(String this.url);

  toJson() => url;

  static Link fromJson(json) => Link(json);
}

/// A Link object.
///
/// http://jsonapi.org/format/#document-links
class LinkObject implements Link {
  final String url;
  final bool isObject = true;
  final Meta meta;

  LinkObject(String this.url, {Map<String, dynamic> meta})
      : meta = Meta.fromJson(meta);

  toJson() {
    final Map<String, dynamic> json = {'href': url};
    if (meta != null) json['meta'] = meta;
    return json;
  }
}
