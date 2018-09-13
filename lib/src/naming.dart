/// JSON API Document naming rules
abstract class Naming {
  /// Is [name] allowed by the rules
  bool allows(String name);

  const Naming();

  void enforce(String name) {
    if (!allows(name))
      throw ArgumentError('Member name "$name" is not allowed by naming rules');
  }
}
