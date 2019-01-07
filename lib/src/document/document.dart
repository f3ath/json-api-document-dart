import 'package:json_api_document/src/document/api.dart';
import 'package:json_api_document/src/document/data_document.dart';
import 'package:json_api_document/src/document/error_document.dart';
import 'package:json_api_document/src/document/friendly_to_string.dart';
import 'package:json_api_document/src/document/link.dart';
import 'package:json_api_document/src/document/meta.dart';
import 'package:json_api_document/src/document/meta_document.dart';

/// The base class for MetaDocument, DataDocument, and ErrorDocument.
abstract class Document with FriendlyToString {
  static const mediaType = 'application/vnd.api+json';

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
  /// The [preferResource] flag controls the behaviour in ambiguous cases.
  static Document fromJson(Map<String, dynamic> json,
      {bool preferResource = false}) {
    if (json.containsKey('errors')) return ErrorDocument.fromJson(json);
    if (json.containsKey('data'))
      return DataDocument.fromJson(json, preferResource: preferResource);
    if (json.containsKey('meta')) return MetaDocument.fromJson(json);
    throw FormatException('Failed to parse a Document.', json);
  }
}