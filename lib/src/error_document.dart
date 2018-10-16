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

  toJson() => super.toJson()..['errors'] = errors;
}
