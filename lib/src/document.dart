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

  Document({Map<String, dynamic> meta, Api this.api, Link this.self})
      : meta = Meta.fromJson(meta);

  /// Returns the JSON representation.
  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    if (meta != null) json['meta'] = meta;
    if (api != null) json['jsonapi'] = api;
    if (self != null) json['links'] = {'self': self};
    return json;
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
