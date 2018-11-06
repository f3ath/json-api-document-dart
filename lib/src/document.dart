import 'package:json_api_document/src/api.dart';
import 'package:json_api_document/src/data_document.dart';
import 'package:json_api_document/src/error_document.dart';
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

  Document({Map<String, dynamic> meta, this.api, this.self})
      : meta = Meta.orNull(meta);

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
  /// a [FormatException] is thrown.
  static Document fromJson(Map<String, dynamic> json) {
    if (json.containsKey('errors')) return ErrorDocument.fromJson(json);
    if (json.containsKey('data')) return DataDocument.fromJson(json);
    if (json.containsKey('meta')) return MetaDocument.fromJson(json);
    throw FormatException('Failed to parse a Document.', json);
  }
}
