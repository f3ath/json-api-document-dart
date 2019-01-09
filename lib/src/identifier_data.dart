import 'package:json_api_document/src/friendly_to_string.dart';
import 'package:json_api_document/src/identifier.dart';
import 'package:json_api_document/src/primary_data.dart';
import 'package:json_api_document/src/resource.dart';

class IdentifierData with FriendlyToString implements PrimaryData {
  final Identifier _identifier;

  IdentifierData(Identifier this._identifier);

  bool identifies(Resource resource) =>
      _identifier.type == resource.type && _identifier.id == resource.id;

  Map<String, dynamic> toJson() => _identifier.toJson();

  List<Resource> get resources => const [];
}
