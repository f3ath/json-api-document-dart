import 'package:json_api_document/src/api.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/meta.dart';
import 'package:json_api_document/src/meta_document.dart';

/// The base class for MetaDocument, DataDocument, and ErrorDocument.
abstract class Document {
  /// The top-level meta information
  final Meta meta;

  /// The JSON API object
  final Api api;
  final Link self;
  final Link related;
  final Link next;
  final Link last;

  Document(
      {Map<String, dynamic> meta,
      Api this.api,
      Link this.next,
      Link this.last,
      Link this.self,
      Link this.related})
      : meta = Meta.fromJson(meta);

  /// Returns the JSON representation.
  Map<String, dynamic> toJson() {
    final j = Map<String, dynamic>();
    if (meta != null) j['meta'] = meta;
    if (api != null) j['jsonapi'] = api;
    final links = {'self': self, 'related': related, 'next': next, 'last': last}
      ..removeWhere((name, link) => link == null);

    if (links.isNotEmpty) j['links'] = links;
    return j;
  }

  /// Creates a Document instance from [json].
  ///
  /// The instance may be a MetaDocument, a DataDocument, or an ErrorDocument
  /// depending on the [json]. If [json] does not match any of the above,
  /// a `CastError` is thrown.
  static Document fromJson(Map<String, dynamic> json) {
    final links = json['links'];
    final self = links != null ? Link.fromJson(links['self']) : null;
    if (json.containsKey('meta')) {
      return MetaDocument(json['meta'],
          api: Api.fromJson(json['jsonapi']), self: self);
    }
    throw CastError();
  }
}
