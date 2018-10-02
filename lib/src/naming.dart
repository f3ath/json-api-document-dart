/// JSON API Document naming rules
class Naming {
  static final _disallowFirst = new RegExp(r'^[^_ -]');
  static final _disallowLast = new RegExp(r'[^_ -]$');
  static final _allowGlobally = new RegExp(r'^[a-zA-Z0-9_ \u0080-\uffff-]+$');

  const Naming();

  /// Is [name] allowed by the rules
  bool allows(String name) =>
      _disallowFirst.hasMatch(name) &&
      _disallowLast.hasMatch(name) &&
      _allowGlobally.hasMatch(name);

  /// Throws ArgumentError if [name] does not comply with the naming rules
  void enforce(String name) {
    if (!allows(name))
      throw ArgumentError(
          'Member name "$name" is not allowed by the naming rules');
  }
}
