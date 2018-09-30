import 'api.dart';
import 'document.dart';
import 'identifier.dart';
import 'link.dart';
import 'meta.dart';
import 'resource.dart';

class DataDocument extends Document {
  dynamic _data;

  DataDocument.fromNull({Meta meta, Api api, Link self})
      : super(meta: meta, api: api, self: self) {
    _data = null;
  }

  DataDocument.fromIdentifier(Identifier this._data,
      {Meta meta, Api api, Link self})
      : super(meta: meta, api: api, self: self) {}

  DataDocument.fromIdentifierList(List<Identifier> this._data,
      {Meta meta, Api api, Link self})
      : super(meta: meta, api: api, self: self) {}

  DataDocument.fromResource(Resource this._data) {}

  toJson() => super.toJson()..['data'] = _data;
}
