import 'package:json_api_document/src/decoding_exception.dart';
import 'package:json_api_document/src/functions/decode_map.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';
import 'package:json_api_document/src/resource_object.dart';

/// Represents a single resource or a single related resource of a to-one relationship
class ResourceData extends PrimaryData {
  final ResourceObject resourceObject;

  ResourceData(this.resourceObject,
      {Link self, Iterable<ResourceObject> included})
      : super(self: self, included: included);

  static ResourceData decodeJson(Object json) {
    if (json is Map) {
      final links = decodeMap(json['links'], Link.decodeJson);
      final included = json['included'];
      final resources = <ResourceObject>[];
      if (included is List) {
        resources.addAll(included.map(ResourceObject.decodeJson));
      }
      final data = ResourceObject.decodeJson(json['data']);
      return ResourceData(data,
          self: links['self'],
          included: resources.isNotEmpty ? resources : null);
    }
    throw DecodingException('Can not decode SingleResourceObject from $json');
  }

  @override
  Map<String, Object> toJson() {
    final links = toLinks();

    return {
      ...super.toJson(),
      'data': resourceObject,
      if (included != null && included.isNotEmpty) ...{'included': included},
      if (links.isNotEmpty) ...{'links': links},
    };
  }

  Resource toResource() => resourceObject.toResource();

  bool identifies(ResourceObject r) => resourceObject.identifies(r);
}
