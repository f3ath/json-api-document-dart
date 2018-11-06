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
  final Link related;
  final Link first;
  final Link last;
  final Link prev;
  final Link next;

  /// Creates a document with null primary data.
  DataDocument.fromNull({
    List<Resource> included,
    Map<String, dynamic> meta,
    Api api,
    Link self,
    Link related,
  }) : this._internal(
          NullData(),
          included,
          meta: meta,
          api: api,
          self: self,
          related: related,
        );

  /// Creates a document with a single resource identifier primary data.
  DataDocument.fromIdentifier(
    Identifier identifier, {
    List<Resource> included,
    Map<String, dynamic> meta,
    Api api,
    Link self,
  }) : this._internal(
          IdentifierData(identifier),
          included,
          meta: meta,
          api: api,
          self: self,
        );

  /// Creates a document with multiple resource identifiers primary data.
  DataDocument.fromIdentifierList(
    List<Identifier> identifiers, {
    List<Resource> included,
    Map<String, dynamic> meta,
    Api api,
    Link self,
    Link first,
    Link last,
    Link prev,
    Link next,
  }) : this._internal(
          IdentifierListData(identifiers),
          included,
          meta: meta,
          api: api,
          self: self,
          first: first,
          last: last,
          prev: prev,
          next: next,
        );

  /// Creates a document with a single resource primary data.
  DataDocument.fromResource(
    Resource resource, {
    List<Resource> included,
    Map<String, dynamic> meta,
    Api api,
    Link self,
    Link related,
  }) : this._internal(
          ResourceData(resource),
          included,
          meta: meta,
          api: api,
          self: self,
          related: related,
        );

  /// Creates a document with multiple resources primary data.
  DataDocument.fromResourceList(
    List<Resource> resources, {
    List<Resource> included,
    Map<String, dynamic> meta,
    Api api,
    Link self,
    Link related,
    Link first,
    Link last,
    Link prev,
    Link next,
  }) : this._internal(
          ResourceListData(resources),
          included,
          meta: meta,
          api: api,
          self: self,
          related: related,
          first: first,
          last: last,
          prev: prev,
          next: next,
        );

  DataDocument._internal(PrimaryData this.data, List<Resource> included,
      {Map<String, dynamic> meta,
      Api api,
      Link self,
      this.related,
      this.first,
      this.last,
      this.prev,
      this.next})
      : included = included == null ? null : List.unmodifiable(included),
        super(meta: meta, api: api, self: self) {
    if (isCompound) {
      final Set<String> seen = Set<String>();
      final isUnique = (included + data.resources)
          .every((res) => seen.add(res.type + ':' + res.id));
      if (!isUnique) throw ArgumentError();
    }
  }

  /// Returns true if the document is fully linked
  ///
  /// http://jsonapi.org/format/#document-compound-documents
  bool get isFullyLinked =>
      !isCompound ||
      included.every((res) =>
          data.identifies(res) ||
          included
              .where((another) => another != res)
              .any((another) => another.identifies(res)));

  /// Returns true is the document is compound
  ///
  /// http://jsonapi.org/format/#document-compound-documents
  bool get isCompound => included != null && included.isNotEmpty;

  toJson() {
    final json = super.toJson();
    json['data'] = data;
    if (isCompound) json['included'] = included;

    final links = {
      'self': self,
      'related': related,
      'first': first,
      'last': last,
      'prev': prev,
      'next': next
    }..removeWhere((name, link) => link == null);
    if (links.isNotEmpty) json['links'] = links;

    return json;
  }

  /// Parses [json] into [DataDocument].
  static DataDocument fromJson(Map<String, dynamic> json) {
    final api = Api.fromJson(json['jsonapi']);
    Link self, related, first, last, prev, next;
    final links = json['links'];
    if (links is Map) {
      if (links['self'] != null) self = Link.fromJson(links['self']);
      if (links['related'] != null) related = Link.fromJson(links['related']);
      if (links['first'] != null) first = Link.fromJson(links['first']);
      if (links['last'] != null) last = Link.fromJson(links['last']);
      if (links['prev'] != null) prev = Link.fromJson(links['prev']);
      if (links['next'] != null) next = Link.fromJson(links['next']);
    }
    final included = json['included'];

    final data = json['data'];
    if (data == null) {
      return DataDocument.fromNull(
          meta: json['meta'], api: api, self: self, related: related);
    }
    if (data is Map) {
      final id = Identifier.fromJson(data);
      return DataDocument.fromIdentifier(id,
          meta: json['meta'],
          api: api,
          self: self,
          included: included is List<Map<String, dynamic>>
              ? included.map(Resource.fromJson).toList()
              : null);
    }
    if (data is List) {
      List<Identifier> ids = [];
      data.forEach((j) {
        if (j is Map) {
          ids.add(Identifier.fromJson(j));
        } else {
          throw FormatException('Failed to parse Identifier.', j);
        }
      });
      return DataDocument.fromIdentifierList(ids,
          meta: json['meta'],
          api: api,
          self: self,
          first: first,
          last: last,
          prev: prev,
          next: next);
    }
    return null;
  }
}
