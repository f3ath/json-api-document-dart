import 'package:json_api_document/json_api_document.dart';

/// JSON API Document naming rules
class Naming {
  static final _disallowFirst = new RegExp(r'^[^_ -]');
  static final _disallowLast = new RegExp(r'[^_ -]$');
  static final _allowGlobally = new RegExp(r'^[a-zA-Z0-9_ \u0080-\uffff-]+$');

  static final _map = Map<Type, Naming>()
    ..[Naming] = const Naming()
    ..[StrictNaming] = const StrictNaming();

  /// Get naming rules instance
  static Naming get(Type type) => _map[type];

  /// Register naming rules
  static register(Naming naming) => _map[naming.runtimeType] = naming;

  const Naming();

  /// Throws ArgumentError if [name] does not comply with the naming rules
  void enforce(String name) {
    if (!allows(name))
      throw ArgumentError(
          'Member name "$name" is not allowed by ${runtimeType} naming rules');
  }

  /// Is [name] allowed by the rules
  bool allows(String name) =>
      _disallowFirst.hasMatch(name) &&
      _disallowLast.hasMatch(name) &&
      _allowGlobally.hasMatch(name);
}
