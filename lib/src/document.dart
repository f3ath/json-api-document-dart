import 'package:json_api_document/src/error.dart';
import 'package:json_api_document/src/json_api.dart';
import 'package:json_api_document/src/primary_data.dart';

class Document<Data extends PrimaryData> {
  /// The Primary Data
  final Data data;
  final JsonApi api;

  final List<JsonApiError> errors;
  final Map<String, Object> meta;

  /// Create a document with primary data
  Document(this.data, {Map<String, Object> meta, this.api})
      : this.errors = null,
        this.meta = (meta == null ? null : Map.from(meta));

  /// Create a document with errors (no primary data)
  Document.error(Iterable<JsonApiError> errors,
      {Map<String, Object> meta, this.api})
      : this.data = null,
        this.errors = List.from(errors),
        this.meta = (meta == null ? null : Map.from(meta));

  /// Create an empty document (no primary data and no errors)
  Document.empty(Map<String, Object> meta, {this.api})
      : this.data = null,
        this.errors = null,
        this.meta = (meta == null ? null : Map.from(meta)) {
    ArgumentError.checkNotNull(meta, 'meta');
  }

  Map<String, Object> toJson() {
    Map<String, Object> json = {};
    if (data != null) {
      json = data.toJson();
    } else if (errors != null) {
      json = {'errors': errors.map(_errorToJson).toList()};
    }
    if (meta != null) {
      json['meta'] = meta;
    }
    if (api != null) {
      json['jsonapi'] = api;
    }
    return json;
  }

  Map<String, Object> _errorToJson(JsonApiError error) {
    final json = <String, Object>{};

    if (error.id != null) json['id'] = error.id;
    if (error.status != null) json['status'] = error.status;
    if (error.code != null) json['code'] = error.code;
    if (error.title != null) json['title'] = error.title;
    if (error.detail != null) json['detail'] = error.detail;
    if (error.meta.isNotEmpty) json['meta'] = error.meta;
    if (error.about != null) json['links'] = {'about': error.about};

    final source = Map<String, String>();
    if (error.sourcePointer != null) source['pointer'] = error.sourcePointer;
    if (error.sourceParameter != null)
      source['parameter'] = error.sourceParameter;
    if (source.isNotEmpty) json['source'] = source;
    return json;
  }
}
