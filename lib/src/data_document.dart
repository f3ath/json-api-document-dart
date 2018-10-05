import 'package:json_api_document/src/api.dart';
import 'package:json_api_document/src/document.dart';
import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/identifier_data.dart';
import 'package:json_api_document/src/identifier_list_data.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/null_data.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';
import 'package:json_api_document/src/resource_data.dart';
import 'package:json_api_document/src/resource_list_data.dart';

/// A Document with top-level primary data
class DataDocument extends Document {
  final PrimaryData data;
  final List<Resource> _included;

  DataDocument.fromNull({Map<String, dynamic> meta, Api api, Link self})
      : _included = [],
        data = NullData(),
        super(meta: meta, api: api, self: self);

  DataDocument.fromIdentifier(Identifier identifier,
      {Map<String, dynamic> meta,
      Api api,
      Link self,
      List<Resource> included = const []})
      : _included = included,
        data = IdentifierData(identifier),
        super(meta: meta, api: api, self: self);

  DataDocument.fromIdentifierList(List<Identifier> identifiers,
      {Map<String, dynamic> meta,
      Api api,
      Link self,
      List<Resource> included = const []})
      : _included = included,
        data = IdentifierListData(identifiers),
        super(meta: meta, api: api, self: self);

  DataDocument.fromResource(Resource resource,
      {Map<String, dynamic> meta,
      Api api,
      Link self,
      List<Resource> included = const []})
      : _included = included,
        data = ResourceData(resource),
        super(meta: meta, api: api, self: self);

  DataDocument.fromResourceList(List<Resource> resources,
      {Link self, Link next, Link last, List<Resource> included = const []})
      : _included = included,
        data = ResourceListData(resources),
        super(self: self, next: next, last: last);

  /// Returns true if the document is fully linked
  ///
  /// http://jsonapi.org/format/#document-compound-documents
  bool get isFullyLinked {
    return _included.isEmpty ||
        _included.every((res) =>
            data.identifies(res) ||
            _included
                .any((another) => another != res && another.identifies(res)));
  }

  /// Returns true is the document is compound
  ///
  /// http://jsonapi.org/format/#document-compound-documents
  bool get isCompound => _included.isNotEmpty;

  toJson() {
    final j = super.toJson();
    j['data'] = data;
    if (_included.isNotEmpty) j['included'] = _included;
    return j;
  }
}
