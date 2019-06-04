import 'package:json_api_document/src/decoding_exception.dart';
import 'package:json_api_document/src/meta_property.dart';

/// Details: https://jsonapi.org/format/#document-jsonapi-object
class JsonApi with MetaProperty {
  final String version;

  JsonApi({this.version, Map<String, Object> meta}) {
    this.meta.addAll(meta ?? {});
  }

  static JsonApi decodeJson(Object json) {
    if (json is Map) {
      return JsonApi(version: json['version'], meta: json['meta']);
    }
    throw DecodingException('Can not decode JsonApi from $json');
  }

  Map<String, Object> toJson() => {
        if (version != null) ...{'version': version},
        if (meta.isNotEmpty) ...{'meta': meta},
      };
}
