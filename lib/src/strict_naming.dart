import 'naming.dart';

/// Strict naming rules
class StrictNaming extends Naming {
  static final _disallowFirst = new RegExp(r'^[^_-]');
  static final _disallowLast = new RegExp(r'[^_-]$');
  static final _allowGlobally = new RegExp(r'^[a-zA-Z0-9_-]+$');

  const StrictNaming();

  bool allows(String name) =>
      _disallowFirst.hasMatch(name) &&
      _disallowLast.hasMatch(name) &&
      _allowGlobally.hasMatch(name);
}
