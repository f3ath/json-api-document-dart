part of '../json_api_document.dart';

class ResourceIdentifier<N extends Naming> {
  final String type;
  final String id;

  ResourceIdentifier(String this.type, String this.id) {
    if (id == null || id.isEmpty) throw ArgumentError();
    Naming.get(N).enforce(type);
  }

  toJson() => {'type': type, 'id': id};
}
