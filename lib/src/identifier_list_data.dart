import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class IdentifierListData implements PrimaryData {
  final List<Identifier> _identifiers;

  IdentifierListData(List<Identifier> this._identifiers);

  @override
  bool identifies(Resource resource) => _identifiers.any((identifier) =>
      identifier.type == resource.type && identifier.id == resource.id);

  @override
  toJson() => _identifiers;
}
