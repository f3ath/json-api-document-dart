import 'package:json_api_document/src/document/api.dart';
import 'package:json_api_document/src/document/document.dart';
import 'package:json_api_document/src/document/link.dart';

class MetaDocument extends Document {
  MetaDocument(Map<String, dynamic> meta, {Api api, Link self})
      : super(meta: meta, api: api, self: self) {
    if (meta == null) throw ArgumentError();
  }

  /// Parses [json] object into [MetaDocument].
  static MetaDocument fromJson(Map<String, dynamic> json) {
    final links = json['links'];
    final self = links != null ? Link.fromJson(links['self']) : null;
    return MetaDocument(json['meta'],
        api: Api.fromJson(json['jsonapi']), self: self);
  }
}
