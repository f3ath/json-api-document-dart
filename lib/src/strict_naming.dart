import 'package:json_api_document/json_api_document.dart';

class StrictNaming implements Naming {
  static final _disallowFirst = new RegExp(r'^[^_-]');
  static final _disallowLast = new RegExp(r'[^_-]$');
  static final _allowGlobal = new RegExp(r'^[a-zA-Z0-9_-]+$');

  const StrictNaming();

  bool allows(String name) =>
      _disallowFirst.hasMatch(name) &&
      _disallowLast.hasMatch(name) &&
      _allowGlobal.hasMatch(name);
}
