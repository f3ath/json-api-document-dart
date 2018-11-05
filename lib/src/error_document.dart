import 'package:json_api_document/src/api.dart';
import 'package:json_api_document/src/document.dart';
import 'package:json_api_document/src/error_object.dart';
import 'package:json_api_document/src/link.dart';

/// A document containing just errors
class ErrorDocument extends Document {
  final List<ErrorObject> errors;

  ErrorDocument(List<ErrorObject> errors,
      {Map<String, dynamic> meta, Api api, Link self})
      : errors = List.unmodifiable(errors),
        super(meta: meta, api: api, self: self);

  /// Parse a [json] object.
  static ErrorDocument fromJson(Map<String, dynamic> json) {
    if (json['errors'] is! List<Map<String, dynamic>>) throw CastError();
    Link self;
    if (json['links'] is Map<String, dynamic>) {
      self = Link.fromJson(json['links']['self']);
    }
    return ErrorDocument(
        (json['errors'] as List<Map<String, dynamic>>)
            .map(ErrorObject.fromJson)
            .toList(),
        meta: json['meta'],
        api: Api.fromJson(json['jsonapi']),
        self: self);
  }

  toJson() => super.toJson()..['errors'] = errors;
}
