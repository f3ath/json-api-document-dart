import 'api.dart';
import 'document.dart';
import 'error_object.dart';
import 'link.dart';
import 'meta.dart';

class ErrorDocument extends Document {
  final List<ErrorObject> _errors;

  ErrorDocument(List<ErrorObject> this._errors,
      {Meta meta, Api api, Link self})
      : super(meta: meta, api: api, self: self);

  get errors => List.from(_errors);

  toJson() => super.toJson()..['errors'] = errors;
}
