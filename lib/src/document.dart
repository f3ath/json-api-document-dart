import 'package:json_api_document/src/error_object.dart';
import 'package:json_api_document/src/json_api.dart';
import 'package:json_api_document/src/primary_data.dart';

class JsonApiDocument<Data extends PrimaryData> {
  /// The Primary Data
  final Data data;
  final JsonApi api;

  final List<ErrorObject> errors;
  final Map<String, Object> meta;

  JsonApiDocument(this.data, {Map<String, Object> meta, this.api})
      : this.errors = null,
        this.meta = (meta == null ? null : Map.from(meta));

  JsonApiDocument.error(Iterable<ErrorObject> errors,
      {Map<String, Object> meta, this.api})
      : this.data = null,
        this.errors = List.from(errors),
        this.meta = (meta == null ? null : Map.from(meta));

  JsonApiDocument.empty(Map<String, Object> meta, {this.api})
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
      json = {'errors': errors};
    }
    if (meta != null) {
      json['meta'] = meta;
    }
    if (api != null) {
      json['jsonapi'] = api;
    }
    // TODO: add `jsonapi` member
    return json;
  }
}
