import 'package:json_api_document/src/meta.dart';

/// A Link.
///
/// http://jsonapi.org/format/#document-links
class Link {
  final String url;

  Link(String this.url);

  toJson() => url;

  /// Parses [json] into [Link] or [LinkObject]. Throws [CastError] on failure.
  static Link fromJson(json) {
    if (json is String) return Link(json);
    if (json is Map<String, dynamic>) return LinkObject.fromJson(json);
    throw CastError();
  }
}

/// A Link object.
///
/// http://jsonapi.org/format/#document-links
class LinkObject implements Link {
  final String url;
  final Meta meta;

  LinkObject(String this.url, {Map<String, dynamic> meta})
      : meta = Meta.fromJson(meta);

  toJson() {
    final Map<String, dynamic> json = {'href': url};
    if (meta != null) json['meta'] = meta;
    return json;
  }

  /// Parses [json] into [LinksObject]. Throws [CastError] on failure.
  static LinkObject fromJson(Map<String, dynamic> json) {
    return LinkObject(json['href'], meta: json['meta']);
  }
}
