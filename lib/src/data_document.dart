import 'api.dart';
import 'document.dart';
import 'link.dart';
import 'meta.dart';
import 'resource_identifier.dart';

class DataDocument extends Document {
  dynamic _data;

  DataDocument.fromNull({Meta meta, Api api, Link self})
      : super(meta: meta, api: api, self: self) {
    _data = null;
  }

  DataDocument.fromResourceIdentifier(ResourceIdentifier this._data,
      {Meta meta, Api api, Link self})
      : super(meta: meta, api: api, self: self) {}

  DataDocument.fromResourceIdentifierList(List<ResourceIdentifier> this._data,
      {Meta meta, Api api, Link self})
      : super(meta: meta, api: api, self: self) {}

  toJson() => super.toJson()..['data'] = _data;
}
