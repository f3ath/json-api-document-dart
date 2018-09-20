part of '../json_api_document.dart';

/// JSON API Object. See http://jsonapi.org/format/#document-jsonapi-object
class Api<N extends Naming> {
  final String version;
  final Meta<N> meta;

  Api(String this.version, {Meta<N> this.meta});

  toJson() {
    final Map<String, dynamic> j = {'version': version};
    if (meta != null) j['meta'] = meta;
    return j;
  }
}
