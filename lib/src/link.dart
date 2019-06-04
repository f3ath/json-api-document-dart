import 'package:json_api_document/src/decoding_exception.dart';
import 'package:json_api_document/src/meta_property.dart';

/// A JSON:API link
/// https://jsonapi.org/format/#document-links
class Link {
  final Uri uri;

  Link(this.uri) {
    ArgumentError.checkNotNull(uri, 'uri');
  }

  static Link decodeJson(Object json) {
    if (json is String) return Link(Uri.parse(json));
    if (json is Map) return LinkObject.decodeJson(json);
    throw DecodingException('Can not decode Link from $json');
  }

  toJson() => uri.toString();

  @override
  String toString() => uri.toString();
}

/// A JSON:API link object
/// https://jsonapi.org/format/#document-links
class LinkObject extends Link with MetaProperty {
  LinkObject(Uri href, {Map<String, Object> meta}) : super(href) {
    this.meta.addAll(meta ?? {});
  }

  static LinkObject decodeJson(Object json) {
    if (json is Map) {
      final href = json['href'];
      if (href is String) {
        return LinkObject(Uri.parse(href), meta: json['meta']);
      }
    }
    throw DecodingException('Can not decode LinkObject from $json');
  }

  toJson() {
    final json = <String, Object>{'href': uri.toString()};
    if (meta != null && meta.isNotEmpty) json['meta'] = meta;
    return json;
  }
}
