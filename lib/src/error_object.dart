import 'link.dart';
import 'utils.dart';

class ErrorObject {
  final _json = {};

  Map<String, dynamic> get json => new Map.unmodifiable(_json);

  ErrorObject(
      {String id,
      Link about,
      String status,
      String code,
      String title,
      String detail,
      String pointer,
      String parameter,
      Map<String, dynamic> meta}) {
    if (id != null) {
      _json['id'] = id;
    }
    if (about != null) {
      _json['links'] = {'about': about.json};
    }
    if (status != null) {
      _json['status'] = status;
    }
    if (code != null) {
      _json['code'] = code;
    }
    if (title != null) {
      _json['title'] = title;
    }
    if (detail != null) {
      _json['detail'] = detail;
    }
    final sourceMembers = {'pointer': pointer, 'parameter': parameter};

    final source = new Map.fromIterable(
        sourceMembers.keys.where((k) => sourceMembers[k] != null),
        value: (k) => sourceMembers[k]);
    if (source.isNotEmpty) {
      _json['source'] = new Map.unmodifiable(source);
    }
    if (meta != null) {
      _json['meta'] = createMeta(meta);
    }
  }
}
