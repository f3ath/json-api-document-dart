/// Details: https://jsonapi.org/format/#document-jsonapi-object
class JsonApi {
  final String version;
  final Map<String, Object> meta;

  JsonApi({this.version, Map<String, Object> meta})
      : meta = meta == null ? null : Map.from(meta);

  Map<String, Object> toJson() {
    final json = <String, Object>{};
    if (version != null) {
      json['version'] = version;
    }
    if (meta != null) {
      json['meta'] = meta;
    }
    return json;
  }
}
