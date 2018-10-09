import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

/// Resources included in a compound document
///
/// http://jsonapi.org/format/#document-compound-documents
class Included {
  final List<Resource> _resources;

  Included(List<Resource> this._resources) {
    final Set<String> seen = Set<String>();
    final isUnique =
        _resources.every((res) => seen.add(res.type + ':' + res.id));
    if (isUnique) return;
    throw ArgumentError();
  }

  bool get isNotEmpty => _resources.isNotEmpty;

  bool get isEmpty => _resources.isEmpty;

  bool isFullyLinkedTo(PrimaryData data) {
    return isEmpty ||
        _resources.every((res) =>
            data.identifies(res) ||
            _resources
                .where((another) => another != res)
                .any((another) => another.identifies(res)));
  }

  toJson() => List.from(_resources);
}
