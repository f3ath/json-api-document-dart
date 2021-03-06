import 'package:json_api_document/src/link.dart';

/// [JsonApiError] represents an error occurred on the server.
///
/// More on this: https://jsonapi.org/format/#errors
class JsonApiError {
  /// A unique identifier for this particular occurrence of the problem.
  String id;

  /// A link that leads to further details about this particular occurrence of the problem.
  Link about;

  /// The HTTP status code applicable to this problem, expressed as a string value.
  String status;

  /// An application-specific error code, expressed as a string value.
  String code;

  /// A short, human-readable summary of the problem that SHOULD NOT change
  /// from occurrence to occurrence of the problem, except for purposes of localization.
  String title;

  /// A human-readable explanation specific to this occurrence of the problem.
  /// Like title, this field’s value can be localized.
  String detail;

  /// A JSON Pointer [RFC6901] to the associated entity in the request document
  /// [e.g. "/data" for a primary data object, or "/data/attributes/title" for a specific attribute].
  String sourcePointer;

  /// A string indicating which URI query parameter caused the error.
  String sourceParameter;

  /// A meta object containing non-standard meta-information about the error.
  final meta = <String, Object>{};

  JsonApiError(
      {this.id,
      this.about,
      this.status,
      this.code,
      this.title,
      this.detail,
      this.sourceParameter,
      this.sourcePointer,
      Map<String, Object> meta}) {
    this.meta.addAll(meta ?? {});
  }
}
