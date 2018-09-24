part of '../json_api_document.dart';

class DataDocument<N extends Naming> extends Document<N> {
  dynamic _data;

  DataDocument.fromNull({Meta<N> meta, Api<N> api, Link<N> self})
      : super(meta: meta, api: api, self: self) {
    _data = null;
  }

  DataDocument.fromResourceIdentifier(ResourceIdentifier<N> this._data,
      {Meta<N> meta, Api<N> api, Link<N> self})
      : super(meta: meta, api: api, self: self) {}

  DataDocument.fromResourceIdentifierList(
      List<ResourceIdentifier<N>> this._data,
      {Meta<N> meta,
      Api<N> api,
      Link<N> self})
      : super(meta: meta, api: api, self: self) {}

  toJson() => super.toJson()..['data'] = _data;
}
