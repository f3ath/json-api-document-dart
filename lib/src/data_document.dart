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
  final List<Resource> included;

  DataDocument.fromNull({
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included = const [],
    Link self,
    Link next,
    Link last,
  }) : this._internal(NullData(), included, meta, api, self, next, last);

  DataDocument.fromIdentifier(
    Identifier identifier, {
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included = const [],
    Link self,
    Link next,
    Link last,
  }) : this._internal(
            IdentifierData(identifier), included, meta, api, self, next, last);

  DataDocument.fromIdentifierList(
    List<Identifier> identifiers, {
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included = const [],
    Link self,
    Link next,
    Link last,
  }) : this._internal(IdentifierListData(identifiers), included, meta, api,
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
            ResourceData(resource), included, meta, api, self, next, last);

  DataDocument.fromResourceList(
    List<Resource> resources, {
    Map<String, dynamic> meta,
    Api api,
    List<Resource> included = const [],
    Link self,
    Link next,
    Link last,
  }) : this._internal(
            ResourceListData(resources), included, meta, api, self, next, last);

  DataDocument._internal(
    PrimaryData this.data,
    List<Resource> included,
    Map<String, dynamic> meta,
    Api api,
    Link self,
    Link next,
    Link last,
  )   : included = List.unmodifiable(included),
        super(meta: meta, api: api, self: self, next: next, last: last) {
    final Set<String> seen = Set<String>();
    final isUnique = (included + data.resources)
        .every((res) => seen.add(res.type + ':' + res.id));
    if (!isUnique) throw ArgumentError();
  }

  /// Returns true if the document is fully linked
  ///
  /// http://jsonapi.org/format/#document-compound-documents
  bool get isFullyLinked =>
      included.isEmpty ||
      included.every((res) =>
          data.identifies(res) ||
          included
              .where((another) => another != res)
              .any((another) => another.identifies(res)));

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
