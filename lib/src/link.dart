import 'meta.dart';

/// A Link.
///
/// http://jsonapi.org/format/#document-links
class Link {
  final String url;
  final isObject = false;
  final Meta meta = null;

  Link(String this.url);

  toJson() => url;

  static Link fromJson(json) => Link(json);
}
