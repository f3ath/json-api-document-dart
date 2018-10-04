import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class IdentifierData implements PrimaryData {
  final Identifier _identifier;

  IdentifierData(Identifier this._identifier);

  @override
  bool identifies(Resource resource) =>
      _identifier.type == resource.type && _identifier.id == resource.id;

  @override
  toJson() => _identifier.toJson();
}
