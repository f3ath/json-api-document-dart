import 'api.dart';
import 'document.dart';
import 'identifier.dart';
import 'link.dart';
import 'resource.dart';

/// A Document with top-level primary data
class DataDocument extends Document {
  final _data;
  final List<Resource> _included;

  DataDocument.fromNull({Map<String, dynamic> meta, Api api, Link self})
      : _included = [],
        _data = null,
        super(meta: meta, api: api, self: self);

  DataDocument.fromIdentifier(Identifier this._data,
      {Map<String, dynamic> meta, Api api, Link self})
      : _included = [],
        super(meta: meta, api: api, self: self);

  DataDocument.fromIdentifierList(List<Identifier> this._data,
      {Map<String, dynamic> meta, Api api, Link self})
      : _included = [],
        super(meta: meta, api: api, self: self);

  DataDocument.fromResource(Resource this._data) : _included = [];

  DataDocument.fromResourceList(List<Resource> this._data,
      {Link self, Link next, Link last, List<Resource> included})
      : _included = included,
        super(self: self, next: next, last: last);

  toJson() {
    final j = super.toJson();
    j['data'] = _data;
    if (_included.isNotEmpty) j['included'] = _included;
    return j;
  }
}
