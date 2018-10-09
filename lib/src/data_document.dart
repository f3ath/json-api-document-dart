import 'package:json_api_document/src/Included.dart';
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
  final Included included;

  DataDocument.fromNull({Map<String, dynamic> meta, Api api, Link self})
      : this._internal(NullData(), meta, api, [], self, null, null);

  DataDocument.fromIdentifier(
    Identifier identifier, {
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included = const [],
    Link self,
    Link next,
    Link last,
  }) : this._internal(
            IdentifierData(identifier), meta, api, included, self, next, last);

  DataDocument.fromIdentifierList(
    List<Identifier> identifiers, {
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included = const [],
    Link self,
    Link next,
    Link last,
  }) : this._internal(IdentifierListData(identifiers), meta, api, included,
            self, next, last);

  DataDocument.fromResource(
    Resource resource, {
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included = const [],
    Link self,
    Link next,
    Link last,
  }) : this._internal(
            ResourceData(resource), meta, api, included, self, next, last);

  DataDocument.fromResourceList(
    List<Resource> resources, {
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included = const [],
    Link self,
    Link next,
    Link last,
  }) : this._internal(
            ResourceListData(resources), meta, api, included, self, next, last);

  DataDocument._internal(
    PrimaryData this.data,
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included,
    Link self,
    Link next,
    Link last,
  )   : included = Included(included),
        super(meta: meta, api: api, self: self, next: next, last: last);

  /// Returns true if the document is fully linked
  ///
  /// http://jsonapi.org/format/#document-compound-documents
  bool get isFullyLinked => included.isFullyLinkedTo(data);

  /// Returns true is the document is compound
  ///
  /// http://jsonapi.org/format/#document-compound-documents
  bool get isCompound => included.isNotEmpty;

  toJson() {
    final j = super.toJson();
    j['data'] = data;
    if (isCompound) j['included'] = included;
    return j;
  }
}
