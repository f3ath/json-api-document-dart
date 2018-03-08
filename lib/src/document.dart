import 'error_object.dart';
import 'link.dart';
import 'utils.dart';

class Document {
  static const version = '1.0';
  final Map<String, dynamic> _json = {};

  /// JSON API Document
  /// [version] - include JSON API version information
  /// [meta] - meta information
  /// [self] = self link
  /// [related] - related link
  Document.fromNull(
      {bool version = false,
      Map<String, dynamic> meta,
      Link self,
      Link related})
      : this._(
            data: const PrimaryData(),
            meta: meta,
            self: self,
            related: related,
            version: version);

  Document.fromErrors(List<ErrorObject> errors,
      {Link self,
      Link related,
      bool version = false,
      Map<String, dynamic> meta})
      : this._(
            errors: errors,
            meta: meta,
            self: self,
            related: related,
            version: version);

  Document.fromMeta(Map<String, dynamic> meta,
      {Link self, Link related, bool version = false})
      : this._(meta: meta, self: self, related: related, version: version);

  Document._(
      {List<ErrorObject> errors,
      PrimaryData data,
      Map<String, dynamic> meta,
      Link self,
      Link related,
      bool version = false}) {
    if (data != null) {
      _json['data'] = data.json;
    }
    if (errors != null) {
      _json['errors'] = new List.unmodifiable(errors.map((e) => e.json));
    }
    if (version) {
      _json['jsonapi'] = const {'version': Document.version};
    }
    if (meta != null) {
      _json['meta'] = createMeta(meta);
    }
    final possibleLinks = {'self': self, 'related': related};
    final links = new Map.fromIterable(
        possibleLinks.keys.where((k) => possibleLinks[k] != null),
        value: (k) => possibleLinks[k].json);
    if (links.isNotEmpty) {
      _json['links'] = new Map.unmodifiable(links);
    }
  }

  toJson() => new Map.unmodifiable(_json);
}

class PrimaryData {
  get json => null;

  const PrimaryData();
}
