import 'meta.dart';

/// JSON API Object. See http://jsonapi.org/format/#document-jsonapi-object
class Api {
  final String version;
  final Meta meta;

  Api(String this.version, {Map<String, dynamic> meta})
      : meta = Meta.fromMap(meta);

  toJson() {
    final Map<String, dynamic> j = {'version': version};
    if (meta != null) j['meta'] = meta;
    return j;
  }

  static Api fromJson(Map<String, dynamic> json) =>
      Api(json['version'], meta: json['meta']);
}
