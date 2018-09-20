part of '../json_api_document.dart';

class ErrorDocument<N extends Naming> extends Document<N> {
  final List<ErrorObject> _errors;

  ErrorDocument(List<ErrorObject<N>> this._errors,
      {Meta<N> meta, Api<N> api, Link<N> self})
      : super(meta: meta, api: api, self: self);

  get errors => List.from(_errors);

  toJson() => super.toJson()..['errors'] = errors;
}
