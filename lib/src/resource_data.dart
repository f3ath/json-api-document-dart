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
