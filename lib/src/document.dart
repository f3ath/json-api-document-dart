import 'error_object.dart';
import 'link.dart';
import 'primary_data.dart';
import 'resource.dart';
import 'resource_identifier.dart';
import 'resurce_identifier_list.dart';
import 'resurce_list.dart';
import 'utils.dart';

class Document {
  static const version = '1.0';
  final Map<String, dynamic> _json = {};

  Document.nullData({
    Map<String, dynamic> meta,
    Link self,
    Link related,
    bool version = false,
  }) : this._internal(
            data: const PrimaryData(),
            meta: meta,
            self: self,
            related: related,
            version: version);

  Document.fromErrors(
    List<ErrorObject> errors, {
    Map<String, dynamic> meta,
    Link self,
    Link related,
    bool version = false,
  }) : this._internal(
            errors: errors,
            meta: meta,
            self: self,
            related: related,
            version: version);

  Document.fromMeta(
    Map<String, dynamic> meta, {
    Link self,
    Link related,
    bool version = false,
  }) : this._internal(
          meta: meta,
          self: self,
          related: related,
          version: version,
        );

  Document.fromResourceIdentifier(
    ResourceIdentifier identifier, {
    Map<String, dynamic> meta,
    Link self,
    Link related,
    bool version = false,
  }) : this._internal(
          data: identifier,
          meta: meta,
          self: self,
          related: related,
          version: version,
        );

  Document.fromResource(
    Resource resource, {
    Map<String, dynamic> meta,
    Link self,
    Link related,
    bool version = false,
  }) : this._internal(
          data: resource,
          meta: meta,
          self: self,
          related: related,
          version: version,
        );

  Document.fromResourceIdentifierList(
    List<ResourceIdentifier> identifiers, {
    Map<String, dynamic> meta,
    Link self,
    Link related,
    bool version = false,
  }) : this._internal(
          data: new ResourceIdentifierList(identifiers),
          meta: meta,
          self: self,
          related: related,
          version: version,
        );

  Document.fromResourceList(
    List<Resource> resources, {
    Map<String, dynamic> meta,
    Link self,
    Link related,
    bool version = false,
  }) : this._internal(
          data: new ResourceList(resources),
          meta: meta,
          self: self,
          related: related,
          version: version,
        );

  Document._internal({
    List<ErrorObject> errors,
    PrimaryData data,
    Map<String, dynamic> meta,
    Link self,
    Link related,
    bool version = false,
  }) {
    if (data != null) {
      _json['data'] = data;
    }
    if (errors != null) {
      _json['errors'] = new List.unmodifiable(errors);
    }
    if (version) {
      _json['jsonapi'] = const {'version': Document.version};
    }
    if (meta != null) {
      _json['meta'] = createMeta(meta);
    }

    final links = removeNulls({'self': self, 'related': related});
    if (links.isNotEmpty) {
      _json['links'] = new Map.unmodifiable(links);
    }
  }

  toJson() => new Map.unmodifiable(_json);
}
