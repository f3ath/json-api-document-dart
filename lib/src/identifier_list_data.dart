import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class IdentifierListData implements PrimaryData {
  final List<Identifier> _identifiers;

  IdentifierListData(List<Identifier> _identifiers)
      : _identifiers = List.unmodifiable(_identifiers);

  bool identifies(Resource resource) => _identifiers.any((identifier) =>
      identifier.type == resource.type && identifier.id == resource.id);

  toJson() => _identifiers;

  List<Resource> get resources => const [];
}
