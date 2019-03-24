
import 'package:json_api_document/src/error.dart';

class ErrorObject {
  final JsonApiError error;

  ErrorObject(this.error);

  Map<String, Object> toJson() {
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
