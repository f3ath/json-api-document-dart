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
  Document.nullData(
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

  Document.fromMeta(Map<String, dynamic> meta,
      {Link self, Link related, bool version = false})
      : this._(meta: meta, self: self, related: related, version: version);

  Document._(
      {PrimaryData data,
      Map<String, dynamic> meta,
      Link self,
      Link related,
      bool version = false}) {
    if (data != null) {
      _json['data'] = data.json;
    }
    if (version) {
      _json['jsonapi'] = const {'version': Document.version};
    }
    if (meta != null) {
      _json['meta'] = createMeta(meta);
    }
    final links = {'self': self, 'related': related};
    final linksObject = new Map.fromIterable(
        links.keys.where((k) => links[k] != null),
        value: (k) => links[k].json);
    if (linksObject.isNotEmpty) {
      _json['links'] = new Map.unmodifiable(linksObject);
    }
  }

  toJson() => new Map.unmodifiable(_json);
}

class PrimaryData {
  get json => null;

  const PrimaryData();
}
