import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/meta.dart';

/// Error object.
///
/// See https://jsonapi.org/format/#errors
class ErrorObject {
  /// A unique identifier for this particular occurrence of the problem.
  final String id;

  /// A link that leads to further details about this particular occurrence of the problem.
  final Link about;

  /// The HTTP status code applicable to this problem, expressed as a string value.
  final String status;

  /// An application-specific error code, expressed as a string value.
  final String code;

  /// A short, human-readable summary of the problem that SHOULD NOT change from
  /// occurrence to occurrence of the problem, except for purposes of localization.
  final String title;

  /// A human-readable explanation specific to this occurrence of the problem.
  /// Like [title], this field’s value can be localized.
  final String detail;

  /// A JSON Pointer [RFC6901](https://tools.ietf.org/html/rfc6901)
  /// to the associated entity in the request document
  final String pointer;

  /// A string indicating which URI query parameter caused the error.
  final String parameter;

  /// A meta object containing non-standard meta-information about the error.
  final Meta meta;
  final _json = Map<String, dynamic>();

  ErrorObject(
      {this.id,
      this.about,
      this.status,
      this.code,
      this.title,
      this.detail,
      this.pointer,
      this.parameter,
      Map<String, dynamic> meta})
      : meta = Meta.fromJson(meta) {
    if (id != null) _json['id'] = id;
    if (status != null) _json['status'] = status;
    if (code != null) _json['code'] = code;
    if (title != null) _json['title'] = title;
    if (detail != null) _json['detail'] = detail;
    if (meta != null) _json['meta'] = meta;
    if (about != null) _json['links'] = {'about': about};
    final source = Map<String, String>();
    if (pointer != null) source['pointer'] = pointer;
    if (parameter != null) source['parameter'] = parameter;
    if (source.length > 0) _json['source'] = source;
  }

  Map<String, dynamic> toJson() {
    return Map.from(_json);
  }

  /// Parses [json] into [ErrorObject].
  static ErrorObject fromJson(Map<String, dynamic> json) {
    String id;
    if (json['id'] is String) id = json['id'];

    Link about;
    if (json['links'] is Map) about = Link.fromJson(json['links']['about']);

    String status;
    if (json['status'] is String) status = json['status'];

    String code;
    if (json['code'] is String) code = json['code'];

    String title;
    if (json['title'] is String) title = json['title'];

    String detail;
    if (json['detail'] is String) detail = json['detail'];

    String pointer;
    String parameter;
    if (json['source'] is Map) {
      if (json['source']['parameter'] is String) {
        parameter = json['source']['parameter'];
      }
      if (json['source']['pointer'] is String) {
        pointer = json['source']['pointer'];
      }
    }

    return ErrorObject(
        id: id,
        about: about,
        status: status,
        code: code,
        title: title,
        detail: detail,
        pointer: pointer,
        parameter: parameter,
        meta: json['meta']);
  }
}
