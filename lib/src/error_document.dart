import 'package:json_api_document/src/api.dart';
import 'package:json_api_document/src/document.dart';
import 'package:json_api_document/src/error_object.dart';
import 'package:json_api_document/src/link.dart';

/// A document containing just errors
class ErrorDocument extends Document {
  ErrorDocument(List<ErrorObject> errors,
      {Map<String, dynamic> meta, Api api, Link self})
      : _errors = List.unmodifiable(errors),
        super(meta: meta, api: api, self: self);

  final List<ErrorObject> _errors;

  Iterable<ErrorObject> get errors => Iterable.castFrom(_errors);

  toJson() => super.toJson()..['errors'] = _errors;

  /// Parses [json] object into [ErrorDocument].
  static ErrorDocument fromJson(Map<String, dynamic> json) {
    final List<ErrorObject> errorObjects = [];
    final errors = json['errors'];
    if (errors is List) {
      errors.forEach((e) {
        if (e is Map<String, dynamic>) {
          errorObjects.add(ErrorObject.fromJson(e));
        } else {
          throw FormatException('Failed to parse an ErrorObject.', e);
        }
      });
    } else {
      throw FormatException('Failed to parse List<ErrorObject>.', errors);
    }
    Link self;
    if (json['links'] is Map<String, dynamic>) {
      self = Link.fromJson(json['links']['self']);
    }
    return ErrorDocument(errorObjects,
        meta: json['meta'], api: Api.fromJson(json['jsonapi']), self: self);
  }
}
