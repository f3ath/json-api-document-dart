import 'package:json_api_document/src/document/identifier.dart';
import 'package:json_api_document/src/document/primary_data.dart';
import 'package:json_api_document/src/document/resource.dart';

class IdentifierData implements PrimaryData {
  final Identifier _identifier;

  IdentifierData(Identifier this._identifier);

  bool identifies(Resource resource) =>
      _identifier.type == resource.type && _identifier.id == resource.id;

  toJson() => _identifier.toJson();

  List<Resource> get resources => const [];
}
