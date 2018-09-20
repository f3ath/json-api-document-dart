part of '../json_api_document.dart';

class DataDocument<N extends Naming> extends Document<N> {
  DataDocument.fromNull({Meta<N> meta, Api<N> api, Link<N> self})
      : super(meta: meta, api: api, self: self);

  toJson() => super.toJson()..['data'] = null;
}
